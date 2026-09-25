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

****

# uxicon

You can find and download free UI/UX design icons in SVG and PNG formats through platforms like [Flaticon](https://www.flaticon.com/free-icons/ux) or [UXing](https://uxwing.com/).

## Where to Find UI/UX Icons

* Flaticon: Offers thousands of vector icons, packs, and customizable styles.
* UXing: Provides free, high-quality SVG and PNG icons for commercial use with no attribution required.
* [Symfony UX Icons](https://ux.symfony.com/icons): A developer tool to render over 200,000 SVG icons directly from Twig templates.

If you need a specific type of icon, tell me:
* What format you need (SVG, PNG, font)
* The style (outline, solid, colored)

## Q. how to include in html

To include an icon in HTML, you can **use an** `<img>` **tag for downloaded SVG/PNG files or an** `<i>` **tag for icon fonts like Font Awesome**.

### Method 1: Using a Downloaded SVG or PNG
If you downloaded an icon from a site like UXwing or Flaticon, save it to your project folder and use the standard image tag.
```html
<!-- For an SVG file (Recommended for sharpness) -->
<img src="icons/ux-design.svg" alt="UX Design Icon" width="24" height="24">
<!-- For a PNG file -->
<img src="images/ux-icon.png" alt="UX Icon" width="32" height="32">
```

### Method 2: Inline SVG (Best for Custom Styling)
You can paste the raw `<svg>` code directly into your HTML. This allows you to easily change its color using CSS.
```html
<svg class="ux-icon" viewBox="0 0 24 24" width="24" height="24">
  <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 17h-2v-2h2v2zm2.07-7.75l-.9.92C13.45 12.9 13 13.5 13 15h-2v-.5c0-1.1.45-2.1 1.17-2.83l1.24-1.26c.37-.36.59-.86.59-1.41 0-1.1-.9-2-2-2s-2 .9-2 2H7c0-2.76 2.24-5 5-5s5 2.24 5 5c0 1.04-.42 1.99-1.07 2.75z"/>
</svg>
```
_You can style this in your CSS file using: `.ux-icon { fill: blue; }`_

### Method 3: Using an Icon Font (Font Awesome)
If you want to use a CDN library without downloading individual files, add the provider's stylesheet to your `<head>` and use an italic tag.
```html
<!DOCTYPE html>
<html lang="en">
<head>
  <!-- 1. Include Font Awesome in your head -->
  <link rel="stylesheet" href="https://cloudflare.com">
</head>
<body>

  <!-- 2. Use the icon anywhere in your body -->
  <i class="fa-solid fa-compass-drafting"></i>

</body>
</html>
```

***

# css make div in center of page vertically

> https://www.freecodecamp.org/news/css-vertical-align-how-to-center-a-div-text-or-an-image-example-code/
>
> https://blog.hubspot.com/website/center-div-css
>
> https://teamtreehouse.com/community/how-do-i-center-only-one-div-on-a-page-both-horizontally-and-vertically

The most reliable, modern way to **center a div vertically** (and horizontally) on a page is using `CSS Flexbox`.

To make it work, you apply the flex properties to the **parent container** (usually the <body> if you want it centered on the entire page) and ensure that the parent container has a defined height.

> https://stackoverflow.com/questions/12771982/vertically-centering-a-div-in-body
>
> https://medium.com/@design.codder12/the-ultimate-guide-to-centering-a-div-in-css-all-methods-explained-c903fcf7e047

### 1. The Flexbox Method (Recommended)
This approach is highly flexible and works perfectly even if you don't know the exact height of your inner div. [Stack Overflow](https://stackoverflow.com/questions/356809/best-way-to-center-a-div-on-a-page-vertically-and-horizontally)
```css
body {
  display: flex;
  justify-content: center; /* Centers horizontally */
  align-items: center;     /* Centers vertically */
  min-height: 100vh;       /* Takes up 100% of the viewport height */
  margin: 0;               /* Removes default browser margins */
}
```

### 2. The CSS Grid Method (The Shortest Way)
If you prefer less code, CSS Grid can achieve the exact same result in just a couple of lines on the parent container. [Mimo](https://mimo.org/tutorials/css/how-to-center-a-div-in-css),[Youtube - Kevin Powell](https://www.youtube.com/shorts/RkL7a6If5L8)
```css
body {
  display: grid;
  place-items: center; /* Centers both vertically and horizontally */
  min-height: 100vh;
  margin: 0;
}
```

### 3. The New Modern Method (No Flex/Grid Required)
In modern CSS, you can now use align-content: center directly on regular block elements without changing the display type to flex or grid. [Youtube - Coding2GO](https://www.youtube.com/watch?v=okd8uqC8Jxs), [Youtube - Kevin Powell](https://www.youtube.com/shorts/RkL7a6If5L8)
```css
body {
  align-content: center;
  min-height: 100vh;
  margin: 0;
}
/* If you also want it horizontally centered */
div {
  margin-inline: auto; 
  width: max-content; 
}
```

#### Why `min-height: 100vh` is crucial
By default, a web page's `<body>` element is only as tall as the content inside it. If your div is the only thing on the page, the body height is small, so the div looks like it's at the top. <br/>
Setting `min-height: 100vh` forces the body to expand to the full height of the user's screen, giving the CSS the vertical space it needs to actually center your element. [Medium](https://medium.com/@design.codder12/the-ultimate-guide-to-centering-a-div-in-css-all-methods-explained-c903fcf7e047), [Stack Overflow](https://stackoverflow.com/questions/12771982/vertically-centering-a-div-in-body)

***

## css current color

The `currentColor` keyword in CSS acts like a built-in variable that represents the current value of an element's color property. It allows you to dynamically sync other properties—like borders, backgrounds, box shadows, and SVG fills—with your text color without redefining the exact color value.
> https://www.w3schools.com/colors/colors_currentcolor.asp
>
> https://www.youtube.com/watch?v=DYI_VE_ToaA&t=79
>
> https://css-tricks.com/currentcolor/
>
> https://egghead.io/lessons/css-leverage-the-css-keyword-currentcolor-to-ensure-a-svg-stroke-inherits-the-font-color

### 💡 How It Works
If an element or its parent has a specific `color` applied, `currentColor` will automatically resolve to that exact color.
> https://blog.master.dev/using-currentcolor-in-2025/
>
> https://www.30secondsofcode.org/css/s/current-color/
```css
.card {
  color: #3b82f6; /* Blue text */
  border: 2px solid currentColor; /* Automatically becomes a 2px blue border */
  background-color: transparent;
}
```
_Because it respects the **CSS Cascade**, if a parent element changes its text color, any child elements utilizing currentColor will instantly update to match._
> https://echobind.com/post/currentcolor-css-property-with-svg
> https://www.30secondsofcode.org/css/s/current-color/

### 🚀 Common Use Cases

**1. Matching SVG Icons to Text**
SVGs inside buttons or text blocks often need to match the font color. Instead of hardcoding fills or writing complex hover states, you can set the SVG attributes in CSS:
> https://css-tricks.com/currentcolor/
>
> https://egghead.io/lessons/css-leverage-the-css-keyword-currentcolor-to-ensure-a-svg-stroke-inherits-the-font-color

```css
.button {
  color: darkgreen;
}
.button:hover {
  color: forestgreen;
}
/* The icon automatically handles both states */
.button svg {
  fill: currentColor; 
  stroke: currentColor;
}
```

**2. Theme-Agnostic Components**
If you are building reusable UI components (like badges or alerts), `currentColor` lets them adapt gracefully depending on where they are placed:
> https://css-tricks.com/currentcolor/
```css
.badge {
  border: 1px solid currentColor;
  box-shadow: 0 2px 4px currentColor;
}
```

**3. Pseudo-elements (::before / ::after)**
You can use it to style decorative elements or custom underlines so they match the text they belong to:
```css
a {
  color: rebeccapurple;
  position: relative;
}
a::after {
  content: '';
  background-color: currentColor; /* Matches rebeccapurple */
  height: 2px;
  width: 100%;
}
```

### ⚠️ Key Things to Keep in Mind

- **Case Insensitivity**: You can type it as `currentColor`, `currentcolor`, or even `CURRENTCOLOR`. The specification treats them identically, though currentColor (camelCase) is the community convention for readability. [Master.dev](https://blog.master.dev/using-currentcolor-in-2025/)
- **Defaults:** Many CSS properties like `border-color`, `text-decoration-color`, and `outlines` **already default** to `currentColor` out of the box if no color is specified. You only need to declare it explicitly when overriding another style or using properties that don't default to it (like `background-colo`r or SVG properties). [Digital Ocean](https://www.digitalocean.com/community/tutorials/css-currentcolor), [CSS-Tricks](https://css-tricks.com/currentcolor/)
- **No Background Equivalent:** There is no `currentBackgroundColor` keyword in CSS. If you need to tie styles to a background color dynamically, you will need to use [CSS Custom Properties (Variables)](https://developer.mozilla.org/en-US/docs/Web/CSS/Using_CSS_custom_properties).
