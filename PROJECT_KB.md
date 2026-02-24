# PROJECT_KB

Purpose: File hash cache for Tiered Reliability Engine.
Prevents redundant verification on unchanged files.

## Fields
- file_path
- sha256_hash
- last_verified_at
- verification_level

## Notes
Entries are appended automatically by Tiered Reliability.
Do not edit manually.
