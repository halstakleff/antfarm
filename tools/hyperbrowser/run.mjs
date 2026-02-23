#!/usr/bin/env node
/**
 * Hyperbrowser SDK Wrapper
 * 
 * Wraps Hyperbrowser API for use in Antfarm scripts.
 * Required env: HYPERBROWSER_API_KEY
 */

import { HyperbrowserClient } from '@hyperbrowser/client';
import fs from 'fs/promises';
import path from 'path';

const API_KEY = process.env.HYPERBROWSER_API_KEY;
if (!API_KEY) {
  console.error('ERROR: HYPERBROWSER_API_KEY not set');
  process.exit(1);
}

const client = new HyperbrowserClient({ apiKey: API_KEY });

async function render(url, options = {}) {
  /**
   * Render a page and return HTML + metadata
   * usage: node run.mjs render <url> [--wait=5000] [--selector=.loaded]
   */
  const session = await client.createSession();
  try {
    const page = await session.newPage();
    
    if (options.wait_ms) {
      await page.goto(url, { waitUntil: 'networkidle' });
      await page.waitForTimeout(parseInt(options.wait_ms));
    } else if (options.selector) {
      await page.goto(url, { waitUntil: 'networkidle' });
      await page.waitForSelector(options.selector);
    } else {
      await page.goto(url, { waitUntil: 'networkidle' });
    }
    
    const html = await page.content();
    const title = await page.title();
    const url_final = page.url();
    
    await session.close();
    
    return {
      success: true,
      url: url_final,
      title,
      html_length: html.length,
      html: options.full_html ? html : html.substring(0, 50000),
      timestamp: new Date().toISOString(),
    };
  } catch (err) {
    await session.close().catch(() => {});
    return { success: false, error: err.message };
  }
}

async function extract(url, selectorSpec) {
  /**
   * Extract structured data using selectors
   * usage: node run.mjs extract <url> '{"title":"h1","price":".price"}'
   */
  const session = await client.createSession();
  try {
    const page = await session.newPage();
    await page.goto(url, { waitUntil: 'networkidle' });
    
    const results = {};
    for (const [key, selector] of Object.entries(selectorSpec)) {
      const elements = await page.$$(selector);
      results[key] = await Promise.all(
        elements.map(async (el) => ({
          text: await el.textContent(),
          html: await el.innerHTML(),
          selector,
        }))
      );
    }
    
    await session.close();
    
    return {
      success: true,
      url,
      extracted: results,
      timestamp: new Date().toISOString(),
    };
  } catch (err) {
    await session.close().catch(() => {});
    return { success: false, error: err.message };
  }
}

async function crawl(seedUrl, rules = {}) {
  /**
   * Multi-page crawl with rules
   * usage: node run.mjs crawl <url> '{"max_pages":10,"include":["/docs"]}'
   */
  const { max_pages = 10, include = [], exclude = [] } = rules;
  const pages = [];
  const visited = new Set();
  const queue = [seedUrl];
  
  const session = await client.createSession();
  
  try {
    while (queue.length && pages.length < max_pages) {
      const url = queue.shift();
      if (visited.has(url)) continue;
      visited.add(url);
      
      // Check include/exclude rules
      const shouldInclude = include.length === 0 || include.some(p => url.includes(p));
      const shouldExclude = exclude.some(p => url.includes(p));
      if (!shouldInclude || shouldExclude) continue;
      
      const page = await session.newPage();
      try {
        await page.goto(url, { waitUntil: 'networkidle' });
        const html = await page.content();
        const title = await page.title();
        
        // Extract links for further crawling
        const links = await page.$$eval('a[href]', as => as.map(a => a.href));
        
        pages.push({
          url,
          title,
          html_length: html.length,
          timestamp: new Date().toISOString(),
        });
        
        // Add new links to queue
        for (const link of links.slice(0, 20)) {
          if (link.startsWith(seedUrl) && !visited.has(link)) {
            queue.push(link);
          }
        }
      } catch (e) {
        console.error(`Failed to crawl ${url}: ${e.message}`);
      }
      
      await page.close();
    }
    
    await session.close();
    
    return {
      success: true,
      seed: seedUrl,
      pages_crawled: pages.length,
      pages,
      timestamp: new Date().toISOString(),
    };
  } catch (err) {
    await session.close().catch(() => {});
    return { success: false, error: err.message };
  }
}

async function screenshot(url) {
  /**
   * Capture screenshot
   * usage: node run.mjs screenshot <url>
   */
  const session = await client.createSession();
  try {
    const page = await session.newPage();
    await page.goto(url, { waitUntil: 'networkidle' });
    const screenshot = await page.screenshot({ fullPage: true });
    
    const outputDir = process.env.HB_SCREENSHOT_DIR || './screenshots';
    await fs.mkdir(outputDir, { recursive: true });
    const filename = `screenshot-${Date.now()}.png`;
    const filepath = path.join(outputDir, filename);
    await fs.writeFile(filepath, screenshot);
    
    await session.close();
    
    return {
      success: true,
      url,
      screenshot_path: filepath,
      timestamp: new Date().toISOString(),
    };
  } catch (err) {
    await session.close().catch(() => {});
    return { success: false, error: err.message };
  }
}

// CLI entry point
const [,, command, ...args] = process.argv;

async function main() {
  switch (command) {
    case 'render': {
      const url = args[0];
      const options = {};
      for (const arg of args.slice(1)) {
        if (arg.startsWith('--wait=')) options.wait_ms = arg.split('=')[1];
        if (arg.startsWith('--selector=')) options.selector = arg.split('=')[1];
        if (arg === '--full-html') options.full_html = true;
      }
      const result = await render(url, options);
      console.log(JSON.stringify(result, null, 2));
      break;
    }
    
    case 'extract': {
      const url = args[0];
      const selectorSpec = JSON.parse(args[1] || '{}');
      const result = await extract(url, selectorSpec);
      console.log(JSON.stringify(result, null, 2));
      break;
    }
    
    case 'crawl': {
      const url = args[0];
      const rules = JSON.parse(args[1] || '{}');
      const result = await crawl(url, rules);
      console.log(JSON.stringify(result, null, 2));
      break;
    }
    
    case 'screenshot': {
      const url = args[0];
      const result = await screenshot(url);
      console.log(JSON.stringify(result, null, 2));
      break;
    }
    
    default:
      console.log(`
Hyperbrowser SDK Wrapper

Usage:
  node run.mjs render <url> [--wait=ms] [--selector=sel] [--full-html]
  node run.mjs extract <url> '{"key":"selector"}'
  node run.mjs crawl <url> '{"max_pages":10}'
  node run.mjs screenshot <url>

Environment:
  HYPERBROWSER_API_KEY - Required API key
  HB_SCREENSHOT_DIR    - Screenshot output directory
      `);
      process.exit(1);
  }
}

main().catch(err => {
  console.error('Fatal error:', err);
  process.exit(1);
});
