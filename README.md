# deck-src

Source files for presentations managed with [deck](https://github.com/conao3/deck), a CLI tool for creating Google Slides from Markdown.

## Getting Started

### Creating a New Presentation

1. **Set up your environment variables**

   ```sh
   BASE_PRESENTATION_ID=1JWgLdXnexIhB6nQtdlwnlwmmy_6HsrbYOL5-UnfO9CE
   GDRIVE_FOLDER_ID=1dTRbbO6J0vVD9kyz0QswejTYyMw0fctx
   NAME=20251018-magit-worktree--ox-deck
   ```

2. **Create the project directory**

   ```sh
   mkdir src/${NAME}
   cd src/${NAME}
   ```

3. **Create your Markdown source file**

   ```sh
   touch main.md
   ```

4. **Generate a new slide deck on Google Drive**

   ```sh
   deck new main.md --base ${BASE_PRESENTATION_ID} --folder-id ${GDRIVE_FOLDER_ID} --title ${NAME}.deck
   ```

5. **Open the presentation in your browser**

   ```sh
   deck open main.md
   ```

6. **Apply changes with live reload**

   ```sh
   deck apply --watch main.md
   ```

## Available Layouts

To list available slide layouts for a presentation:

```sh
deck ls-layouts --presentation-id <presentation-id>
```

Common layouts include:

- `title` - Title slide
- `section` - Section divider
- `title-and-body` - Standard content slide
- `title-and-body-2col` - Two-column layout
- `section-title-and-body` - Section with content
- `takahashi` - Large text, minimal style

## License

CC0
