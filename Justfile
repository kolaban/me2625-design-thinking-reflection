# Based on blog post from https://jaantollander.com/post/scientific-writing-with-markdown/
# Requires pandoc version <3.0.0!
build_dir := "./build/"
manu_dir := "./"
file_name := "content.Rmd"
file_loc := manu_dir + file_name

alias ez := easy-commit

# Build your rmarkdown file
local_render : 
	pixi run render {{file_loc}} {{ build_dir }}
	rm -f {{file_stem(file_name)}}.log # Drop the log file output

# Commits everything and pushes to arepo with "<New content 📚> Added/Updated content" as commit message
easy-commit:
    git add .
    git commit -m "<New content 📚> Added/Updated content"