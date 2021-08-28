# Make executable with chmod +x <<filename.sh>>
# run script from project dir
# step 1: initialize npm and install webpack
npm init -y
npm install webpack webpack-cli --save-dev
# step 2: create src and dist dirs with index.js, style.css, and index.html file templates
mkdir src
mkdir dist
cd src
echo "html, body {
	padding: 0;
	margin: 0;
	height: 100%;
	width: 100%;
}
#content {
    display: flex;
    flex-flow: column;
}" > style.css
echo "import './style.css';" > index.js
cd ../dist
echo "<!DOCTYPE html>
    <html lang=\"en\">
    <head>
        <meta charset=\"utf-8\"/>
        <title>Title</title>    
    </head>
    <body>
        <div id=\"content\">
        </div>
        <script src=\"main.js\"></script>
    </body>
</html>" > index.html
# step 3: create webpack.config.js file at project root and install css loader
cd ..
echo "const path = require('path');

module.exports = {
    mode: 'development',
    entry: './src/index.js',
    devtool: 'inline-source-map',
    output: {
        filename: 'main.js',
        path: path.resolve(__dirname, 'dist'),
    },
    module: {
        rules: [
          {
            test: /\.css$/i,
            use: ['style-loader', 'css-loader'],
          },
          {
            test: /\.(png|svg|jpg|jpeg|gif)$/i,
            type: 'asset/resource',
          },
        ],
    },
};" > webpack.config.js
npm install --save-dev style-loader css-loader
# step 4: create generic .gitignore file
echo "node_modules/
dist/*
!dist/index.html" > .gitignore
# step 5: install ESLint and Prettier, create config and ignore files), install package allowing them to work together
npm install eslint --save-dev
npx eslint --init
npm install --save-dev --save-exact prettier
echo "{
    \"trailingComma\": \"es5\",
    \"tabWidth\": 4,
    \"semi\": true,
    \"singleQuote\": true
}" > .prettierrc.json
echo "node_modules
dist" > .prettierignore
npm install --save-dev eslint-config-prettier
# step 6: use node to add prettier to the extends array of .eslintrc.json
node > out_.eslintrc.json <<EOF
var config = require('./.eslintrc.json');
config['extends'].push("prettier");
console.log(JSON.stringify(config));
EOF
cp out_.eslintrc.json .eslintrc.json
rm out_.eslintrc.json
# step 7: add "build": "webpack" to package.json scripts object
node > out_package.json <<EOF
var config = require('./package.json');
config['scripts']['build'] = 'webpack';
console.log(JSON.stringify(config));
EOF
cp out_package.json package.json
rm out_package.json
npm run build