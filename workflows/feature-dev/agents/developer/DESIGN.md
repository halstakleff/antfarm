# Fork+ Design System & Development Reference

## 🎨 Brand Identity
- **Primary:** `#0D9488` (nit-teal)
- **Primary Dark:** `#0F766E` (nit-teal-dark)
- **Primary Light:** `#14B8A6` (nit-teal-light)
- **Navy:** `#0F172A` (nit-navy)
- **Background:** `#F8FAFC`
- **Accent:** `#F59E0B` (amber for highlights)

## ✨ Premium Design Philosophy
- **Shine effects** on hover for interactive elements
- **Glow effects** for emphasis and CTAs
- **Glassmorphism** for cards and modals (backdrop-blur)
- **Spring physics** (framer-motion) for premium feel
- **Subtle shadows** with color tinting
- **Micro-animations** that delight

## 📱 Mobile-First Responsive (CRITICAL)
- **Touch targets:** Minimum 44x44px
- **Font sizes:** 16px minimum for body, 14px for small
- **Spacing:** 16px base padding for mobile
- **Breakpoints:**
  - Mobile: 0-639px
  - Tablet: 640-1023px  
  - Desktop: 1024px+
- **Images:** Always use responsive images with srcset
- **Forms:** Large inputs (48px height) for touch
- **Navigation:** Hamburger menu on mobile, sidebar on desktop
- **Tables:** Scroll horizontally or transform to cards on mobile

## 🎯 UX Standards (Premium/Sleek/WoW)
1. **Empty States** - Beautiful, not bare. Include illustrations, CTAs
2. **Loading States** - Skeleton screens, shimmer effects
3. **Error States** - Friendly, actionable, with recovery
4. **Transitions** - Smooth, 200-300ms
5. **Hover Effects** - Subtle lifts, glows
6. **Focus States** - Clear keyboard indicators
7. **Accessibility** - WCAG 2.1 AA

## ⚡ Performance Best Practices
- **Lazy load** images and components
- **Code split** by route
- **Memoize** expensive computations
- **Virtual scrolling** for long lists
- **Debounce** search inputs
- **Optimistic UI** for instant feedback
- **Service worker** for offline support
- **Bundle size** < 500KB gzipped

## 🧩 Component Patterns
- **Buttons:** 44px min height, 16px padding
- **Cards:** Glassmorphism, hover lift
- **Modals:** Centered, backdrop blur
- **Inputs:** 48px height, floating labels
- **Badges:** Status indicators
- **Toasts:** Slide in, auto-dismiss

## 🎬 Animation Standards
```typescript
// Spring configs
springSnappy: { stiffness: 300, damping: 20 }
springGentle: { stiffness: 200, damping: 25 }

// Transitions
duration: 200-300ms
ease: "easeOut"

// Mobile: reduce motion
@media (prefers-reduced-motion: reduce) {
  * { animation: none !important; }
}
```

## 🔧 Available Tools
- **Scrollytelling CLI:** `~/mission-control/tools/scrollytelling/`
- **Fluid Components:** FluidToggle, JellyCard, SpringButton
- **Animations:** framer-motion

## 📂 Key Locations
- Components: `resources/js/components/`
- Pages: `resources/js/pages/`
- API: `routes/api.php`

## 🧪 Quality Standards
- TypeScript strict
- ESLint with airbnb config
- Tests for features
- Build must pass
- WCAG 2.1 AA
