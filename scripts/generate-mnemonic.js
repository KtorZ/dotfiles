#!/usr/bin/env node

const m = () => require('bip39').generateMnemonic(160).split(' ').map(x => `"${x}"`).join(", ")
console.log(`[${m()}]`);
