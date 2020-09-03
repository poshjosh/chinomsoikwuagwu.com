---
path: "./2020/08/12/css3-media-queries-quick-reference.md"
date: "2020-08-12T22:09:00"
title: "CSS 3 Media Queries - All over again"
description: "Quick Reference - CSS 3 Media Queries, Cheat sheet"
tags: ["CSS", "Media query", "Media queries", "@media"]
lang: "en-us"
---

### What is a Media Query?

Media query is a CSS technique introduced in CSS3. It is based on the `@media`.
This rule says to include a block of CSS properties only if a certain
condition is true.

Here is an example:

```css
@media only screen and (max-width: 480px) {
    table {
        width: 100%;
    }
}
```

### Always Design for Mobile First

The percent of internet traffic for mobile devices grew from 16.2% in 2013 to
53.3% in 2019. [10](#hostingtribunal-mobile-traffic)[20](#broadbandsearch-mobile-traffic)
In addition, it is projected that about three quarters of internet
users will access the web solely via their smartphones by 2025, according to a
2019 report published by the World Advertising Research Center (WARC) [30](#cnbc-mobile-traffic-projection).

Furthermore, mobile first means designing for mobile before designing for desktop or any other
device (This will make the page display faster on smaller devices).

### Use both `max-width` and `max-device-width` rules

max-width is the width of the target display area

max-device-width is the width of the device's entire rendering area

```css
@media only screen and (max-width: 480px), only screen and (max-device-width: 480px) {

}
```          

### The @media rule comes after the normal CSS  

This won't work:

```css
@media screen and (min-width: 500px) {
    .primary-button {
        background-color: #128ff2;
        box-shadow: 0 2px 2px 0 rgba(0, 0, 0, 0.12);
        color: #fff;
        display: inline-block;
    }
}
.primary-button {
    background-color: #128ff2;
    box-shadow: 0 2px 2px 0 rgba(0, 0, 0, 0.12);
    color: #fff;
    display: block;
    min-width: 100px;
}
```

This is the way to do it:

```css
.primary-button {
    background-color: #128ff2;
    box-shadow: 0 2px 2px 0 rgba(0, 0, 0, 0.12);
    color: #fff;
    display: block;
    min-width: 100px;
}

@media screen and (min-width: 500px) {
    .primary-button {
        background-color: #128ff2;
        box-shadow: 0 2px 2px 0 rgba(0, 0, 0, 0.12);
        color: #fff;
        display: inline-block;
    }
}
```

### Add the viewport meta tag to the head of the respective html document

```html
<meta name="viewport" content="width=device-width, initial-scale=1.0">
```

Without the above, `@media` is a no-op.

### References

- <a name="hostingtribunal-mobile-traffic">10</a>. [Hositing Tribunal - mobile traffic](https://hostingtribunal.com/blog/mobile-percentage-of-traffic/)

- <a name="broadbandsearch-mobile-traffic">20</>. [Broadband Search - mobile traffic](https://www.broadbandsearch.net/blog/mobile-desktop-internet-usage-statistics)

- <a name="cnbc-mobile-traffic-projection">30</a>. [CNBC - smartphone usage projection](https://www.cnbc.com/2019/01/24/smartphones-72percent-of-people-will-use-only-mobile-for-internet-by-2025.html)

### Further Reading

- [W3Schools - Media queries](https://www.w3schools.com/css/css_rwd_mediaqueries.asp)

- [Stackoverflow - Best practice using media queries](https://stackoverflow.com/questions/14947672/what-is-the-best-practice-with-media-queries-in-css3)

- [Smashing Magazine - Media queries and responsive design](https://www.smashingmagazine.com/2018/02/media-queries-responsive-design-2018/)

- [Smashing Magazine - Use CSS3 Media queries for mobile website](https://www.smashingmagazine.com/2010/07/how-to-use-css3-media-queries-to-create-a-mobile-version-of-your-website/)
