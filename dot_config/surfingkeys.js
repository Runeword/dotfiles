settings.blocklistPattern = /.*getpocket.com.*|.*mail.google.com.*|.*docs.google.com.*/
// chrome.storage.local.set({"noPdfViewer": 1})

// Remap keys
api.map('t', 'f');
api.map('yl', 'yy');
api.map('yL', 'yY');
api.map('gh', 'af');
api.map('T', 'gf');
api.map('d', 'yt');
api.map('w', 'gxT');
api.map('W', 'gxt');
api.map('gw', 'gx$');
api.map('gW', 'gx0');


api.unmapAllExcept([
  // Remapped keys
  't',  // Open a link
  'yl', // Copy current page's URL
  'yL', // Copy all tabs's url
  'gh', // Open a link in active new tab
  'T',  // Open a link in non-active new tab
  'd',  // Duplicate current tab
  'w',  // Close tab on right
  'W',  // Close tab on left
  'gw', // Close all tabs on right
  'gW', // Close all tabs on left
  // Default keys
  '<Esc>', // Leave insert mode
  'yv', // Yank text of an element
  'v',  // Toggle visual mode
  'r',  // Reload the page
  '?'   // Show usage
]);

api.Hints.setCharacters = 'aoeuidtnsqjkmwvpyfgcr';

const hintsCss = "font-size: 11pt; font-family: 'JetBrains Mono NL', 'Cascadia Code', 'Helvetica Neue', Helvetica, Arial, sans-serif; border: 0px;";

api.Hints.style(hintsCss);
api.Hints.style(hintsCss, "text");

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
