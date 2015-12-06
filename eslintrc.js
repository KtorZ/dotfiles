module.exports = {
  "ecmaFeatures": {
    "jsx": true
  },

  "rules": {
    "semi": [2, "never"],
    "no-duplicate-case": 2,
    "no-extra-parens": 2,
    "no-extra-semi": 2,
    "no-func-assign": 2,
    "no-inner-declarations": 2,
    "no-invalid-regexp": 2,
    "no-irregular-whitespace": 2,
    "no-unreachable": 2,
    "no-unused-vars": [2, {"vars": "local", "args": "all"}],
    "valid-typeof": 2,
    "curly": 2,
    "eqeqeq": [2, "smart"],
    "no-new": 2,
    "block-spacing": [1, "always"],
    "array-bracket-spacing": [1, "never"],
    "brace-style": [1, "1tbs", { "allowSingleLine": true }],
    "comma-spacing": [1, {"before": false, "after": true}],
    "no-trailing-spaces": 1,
    "no-spaced-func": 1,
    "no-multiple-empty-lines": [1, {"max": 2, "maxEOF": 1}],
    "key-spacing": [1, {"beforeColon": false, "afterColon": true}],
    "no-mixed-spaces-and-tabs": 1,
    "space-after-keywords": [1, "always"],
    "jsx-quotes": [2, "prefer-single"],
    "react/display-name": 0,
    "react/jsx-boolean-value": 2,
    "react/jsx-no-duplicate-props": 2,
    "react/jsx-no-undef": 2,
    "react/jsx-sort-prop-types": 0,
    "react/jsx-sort-props": 0,
    "react/jsx-uses-react": 2,
    "react/jsx-uses-vars": 2,
    "react/no-did-mount-set-state": 0,
    "react/no-did-update-set-state": 2,
    "react/no-multi-comp": 0,
    "react/no-unknown-property": 2,
    "react/prop-types": 2,
    "react/react-in-jsx-scope": 0,
    "react/self-closing-comp": 2,
    "react/sort-comp": 0,
    "react/wrap-multilines": 0
  },

  "environment": {
    browser: true,
    commonjs: true
  },

  "plugins": [
    "react"
  ]
}
