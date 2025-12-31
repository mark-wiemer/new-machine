# New machine: Linux

Programs and configs specific to Linux, not Windows.

## rclone for OneDrive

1. `sudo apt install rclone`
2. `rclone config`
3. Go through the prompts
   - Use the drive with the simplest name (probably the only one that works)
   - Once the remote is setup, type `q` when prompted to quit config
4. `rclone ls onedrive:` to confirm the files are there :)
5. `rclone sync <source> <dest>` for a one-time sync, e.g. `rclone sync onedrive: ./onedrive` to sync remote into local
   - `rclone sync onedrive: ./onedrive --exclude "Personal Vault/**" --verbose` includes recommended options :)
