# Using a Docker volume as npm cache directory

## the why's

1. Speed up npm build (since volumes are quicker than mounted host os paths)
1. freeze your dependencies
1. build without internet connection
1. exchange with the team
1. store for later recreation of the build

## Create a volume

```bash
docker volume create npmcache-first-nestjs
# npmcache-first-nestjs
```

## Collecting the dependencies

1. Open the project to the devcontainer, prefer a rebuild without cache run:

   * <kbd>CMD</kbd><kbd>SHIFT</kbd><kbd>P</kbd>`Rebuild Container without Cache` (type extracts until you see this command) <kbd>enter</kbd>

1. Run the npm build with

    ```bash
    npm ci
    ```

    * Npm will create and update these installation folders

        1. /home/node/.npm/
        1. /workspaces/first-nestjs/node_modules

    * Npm will also create and update the `package-lock.json` to list the exact versions that got downloaded.

## Setup the devcontainer to mount the volume


```json
"mounts": [
    "source=npmcache-first-nestjs,target=/home/node/.npm,readonly,type=volume",
    "source=npmcache-first-nestjs,target=/workspaces/first-nestjs/node_modules,readonly,type=volume"
 ],
```

## Clone the project into the devcontainer

If you have the workspace inside the devcontainer, the project gets cloned to the Docker file system and not to the host os file system.

It also prevents the workspace from being modified in an unforeseen why from the host os side.

> Make sure you push your commits before deleting the devcontainer (ie. when rebuilding the devcontainer without cache). Otherwise uncommitted project files are lost!
