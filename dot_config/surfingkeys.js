settings.blocklistPattern = /.*youtube.com.*|.*mail.google.com.*|.*docs.google.com.*/

// Remap keys
api.map('h', 'f');
api.map('gh', 'af');
api.map('H', 'gf');
api.map('d', 'yt');
api.map('w', 'gxT');
api.map('W', 'gxt');
api.map('gw', 'gx$');
api.map('gW', 'gx0');


api.unmapAllExcept([
  // Remapped keys
  'h',  // Open a link
  'gh', // Open a link in active new tab
  'H',  // Open a link in non-active new tab
  'd',  // Duplicate current tab
  'w',  // Close tab on right
  'W',  // Close tab on left
  'gw', // Close all tabs on right
  'gW', // Close all tabs on left
  // Default keys
  'yy', // Copy current page's URL
  'yY', // Copy all tabs's url
  'yv', // Yank text of an element
  'ya', // Copy a link URL to the clipboard
  'v',  // Toggle visual mode
  'r',  // Reload the page
  '?'   // Show usage
]);

api.Hints.setCharacters('aoeuidtnsqjkmwv.pyfgcr');

settings.theme = `
.sk_theme {
    font-family: Input Sans Condensed, Charcoal, sans-serif;
    font-size: 10pt;
    background: #24272e;
    color: #abb2bf;
}
.sk_theme tbody {
    color: #fff;
}
.sk_theme input {
    color: #d0d0d0;
}
.sk_theme .url {
    color: #61afef;
}
.sk_theme .annotation {
    color: #56b6c2;
}
.sk_theme .omnibar_highlight {
    color: #528bff;
}
.sk_theme .omnibar_timestamp {
    color: #e5c07b;
}
.sk_theme .omnibar_visitcount {
    color: #98c379;
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
    background: #303030;
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
    background: #3e4452;
}
#sk_status, #sk_find {
    font-size: 20pt;
}`;
