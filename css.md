## How to load fonts by using a font.css file

To use Lato fonts via a dedicated `font.css` file, you need to download the font files, define them using the `@font-face` rule in your CSS file, and then link that stylesheet to your HTML page.

> Ref:
> https://npmjs.com/package/lato-font

Here is the complete step-by-step guide to setting it up.

****

**Step 1: Download and Organize Your Font Files**

1. Go to Google Fonts <https://fonts.google.com/> or LatoFonts.com <https://www.latofonts.com/download/> and download the Lato font family zip folder.
2. Extract the file to find the `.ttf`, `.woff`, or `.woff2` font formats.
3. Move these font files into your website project directory. It is best practice to group them in a folder called `fonts/`.
  
Your folder structure should look like this:
```txt
my-website/
│
├── index.html
├── font.css
└── fonts/
    ├── Lato-Regular.ttf
    ├── Lato-Bold.ttf
    └── Lato-Italic.ttf
```
