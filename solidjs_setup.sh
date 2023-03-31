#!/bin/bash

# solidjs initialization
echo "What is the name of your project: "
read project_name
npx degit solidjs/templates/ts $project_name
cd $project_name
npm i 

#babel setup
npm i babel-preset-solid
babelrc='
{
  "presets": [
    "babel-preset-solid"
  ]
}
'
touch .babelrc
echo $babelrc > .babelrc

# modular-forms and zod setup
npm i @modular-forms/solid zod

# solid-router setup
npm i @solidjs/router
sed -i '' '3s/^/import { Router } from "@solidjs\/router";/' src/index.tsx
sed -i '' "s#<App />#<Router><App /></Router>#" src/index.tsx

# suid setup
# npm i suid @suid/material @suid/icons-material @suid/vite-plugin
# sed -i '' '3s/^/import suidPlugin from "@suid\/vite-plugin";\n/' vite.config.ts
# sed -i '' "s#plugins: \[solidPlugin()\],#plugins: \[suidPlugin(), solidPlugin()\],#" vite.config.ts

# tailwindcss setup
npm i -D tailwindcss postcss autoprefixer
npx tailwindcss init -p
sed -i '' '1s/^/@tailwind base;\n@tailwind components;\n@tailwind utilities;\n\n/' src/index.css
sed -i '' "s#content: \[\],#content: \['./src/**/*.{js,jsx,ts,tsx}'\],#" tailwind.config.js

# prettier and eslint setup
npm i -D prettier eslint eslint-plugin-solid @typescript-eslint/eslint-plugin @typescript-eslint/parser eslint-config-airbnb-typescript eslint-config-prettier eslint-plugin-prettier
eslintrc='
{
    "env": {
        "browser": true,
        "es2021": true,
        "node": true
    },
    "extends": [
        "eslint:recommended",
        "airbnb-base",
        "airbnb-typescript/base",
        "plugin:@typescript-eslint/recommended",
        "plugin:@typescript-eslint/recommended-requiring-type-checking",
        "plugin:@typescript-eslint/strict",
        "plugin:solid/typescript",
        "plugin:prettier/recommended"
    ],
    "parser": "@typescript-eslint/parser",
    "parserOptions": { "project": ["./tsconfig.json"] },
    "plugins": ["@typescript-eslint", "solid"],
    "rules": {
        "import/extensions": ["error", "ignorePackages", { "": "never" }],
        "prettier/prettier": ["error", { "endOfLine": "auto" }]
    }
}
'
touch .eslintrc.json
echo $eslintrc > .eslintrc.json
