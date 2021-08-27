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