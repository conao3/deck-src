# deck-src

## Add new presentation

0. Define values.
    ```sh
    BASE_PRESENTATION_ID=1JWgLdXnexIhB6nQtdlwnlwmmy_6HsrbYOL5-UnfO9CE
    GDRIVE_FOLDER_ID=1dTRbbO6J0vVD9kyz0QswejTYyMw0fctx
    NAME=20251018-magit-worktree--ox-deck
    ```
1. Create directory.
    ```sh
    mkdir src/${NAME}
    cd src/${NAME}
    ```
2. Create main.md in it.
    ```sh
    touch ${NAME}
    ```
3. Create slide on gdrive.
    ```sh
    deck new main.md --base ${BASE_PRESENTATION_ID} --folder-id ${GDRIVE_FOLDER_ID} --title ${NAME}.deck
    ```
4. Open the slide via browser.
    ```sh
    deck open main.md
    ```
4. Apply md to slide.
    ```sh
    deck apply --watch main.md
    ```

Tips: List available template

```sh
$ deck ls-layouts --presentation-id <presentation-id>
title
section
title-and-body
title-and-body-2col
section-title-and-body
takahashi
```

## License

CC0
