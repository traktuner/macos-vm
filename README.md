# GitHub runner macOS VM

This project builds a virtual macOS environment for testing purposes.
You get the best connection quality via Apple's own Remote Desktop application.
VNC is also supported.
The VM will automatically connect to the Tailscale wireguard VPN - make sure you enable your Tailscale tunnel on your PC first to connect!

## The following "secrets" have to be defined in the repo-settings:

| Secret              | Description                                                                   |
|---------------------|-------------------------------------------------------------------------------|
| VNC_USER            | local admin account, also needed to login remotely                            |
| VNC_PASSWORD        | password needed to login remotely                                             |
| VNC_USER_PASSWORD   | password for the local admin account                                          |
| TAILSCALE_TOKEN     | Tailscale authentication key                                                  |
