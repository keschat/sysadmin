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

**Step 2: Create and Configure your** `font.css`

Open or create your `font.css` file. Use the `@font-face` rule to map each specific font file to the unified `Lato` family name:
> Ref:
> https://help.lob.com/print-and-mail/designing-mail/no-code-design-suite/figma-connector/custom-fonts

```css
/* Regular Weight */
@font-face {
    font-family: 'Lato';
    src: url('fonts/Lato-Regular.ttf') format('truetype');
    font-weight: 400;
    font-style: normal;
    font-display: swap; /* Improves loading performance */
}

/* Italic Style */
@font-face {
    font-family: 'Lato';
    src: url('fonts/Lato-Italic.ttf') format('truetype');
    font-weight: 400;
    font-style: italic;
    font-display: swap;
}

/* Bold Weight */
@font-face {
    font-family: 'Lato';
    src: url('fonts/Lato-Bold.ttf') format('truetype');
    font-weight: 700;
    font-style: normal;
    font-display: swap;
}
```
_(Note: If you downloaded .woff2 files instead of .ttf, change the format parameter to format('woff2'))._

**Step 3: Link `font.css` in Your HTML**

Open your `index.html` file and link the `font.css` stylesheet inside the `<head>` tags. **Ensure you link it before your main styling sheets** so the font loads before the browser renders the page.
> Ref:
> https://stackoverflow.com/questions/20864279/using-lato-fonts-in-my-css-font-face
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Using Lato Font</title>
    
    <!-- Link the font stylesheet first -->
    <link rel="stylesheet" href="font.css">
</head>
<body>
    <h1>This heading is in Lato</h1>
    <p>This text is also in Lato.</p>
</body>
</html>
```

**Step 4: Apply the Font to Your Elements**

In your main stylesheet (or within the `font.css` file if it handles all global text rules), use the `font-family` property to apply the font. Always provide a generic fallback like `sans-serif`:
> Ref:
> https://blog.logrocket.com/how-to-use-web-fonts-css/
```css
body {
    font-family: 'Lato', sans-serif;
}

h1 {
    font-weight: 700; /* Will automatically trigger Lato-Bold.ttf */
}

p {
    font-weight: 400; /* Will automatically trigger Lato-Regular.ttf */
}
```

***

## rel="noopener"

AI Overview

`rel="noopener"` is an HTML attribute value used on links that open in a new tab or window (via `target="_blank"`) to prevent the newly opened page from accessing your original page through the `window.opener` property.
 > Ref: <br/>
 > https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/rel/noopener <br/>
 > https://dev.to/tlakomy/creating-a-safe-external-html-link-whats-the-deal-with-nofollow-noopener-norefferer--5a4i

### Why It Matters

- **Security Protection:** Without it, a malicious external site opened in a new tab can manipulate your original tab's `window.opener.location` property and quietly redirect your users to a fake phishing or malicious login page (a vulnerability known as "reverse tabnabbing").
   > Ref: <br/>
   > https://help.ahrefs.com/en/articles/4684931-noreferrer-noopener-nofollow-attributes
- **Performance/Isolation:** It forces the new browsing context to run in a separate process or isolates it so it cannot tamper with the originating document.
   > Ref: <br/>
   > https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/rel/noopener <br/>
   > https://dev.to/tlakomy/creating-a-safe-external-html-link-whats-the-deal-with-nofollow-noopener-norefferer--5a4i
- **SEO Impact:** It has zero negative or positive impact on search engine optimization rankings.
 > Ref: <br/>
 > https://elementor.com/blog/noopener-noreferrer/ <br/>
 > https://help.ahrefs.com/en/articles/4684931-noreferrer-noopener-nofollow-attributes  

### How to Use It

Add `rel="noopener"` directly inside an anchor tag that uses `target="_blank"`:
 > Ref: <br/>
 > https://www.dofactory.com/html/rel/noopener <br/>
 > https://help.ahrefs.com/en/articles/4684931-noreferrer-noopener-nofollow-attributes
```html
<a href="https://example.com" target="_blank" rel="noopener">External Link</a>
```
_(Note: While modern browsers now default to noopener behavior for target="_blank" links, explicitly coding rel="noopener" remains a best practice for legacy browser compatibility)._
> Ref: <br/>
> https://blog.openreplay.com/rel-noopener-obsolete-links/
