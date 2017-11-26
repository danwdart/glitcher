# Glitcher

Creates animated glitchy versions of images.

By default, creates 26 different glitched animations and puts them on a page.

## Usage

`glitcher <imagefile> <name>`

## Arguments

`imagefile`: input image

`name`: output file name template

## Outputs

Glitched files are named `<name>-{0-25}.gif` and are included on a page named `<name>.html`.

## Example

`glitcher image1.png image`

will create `image-0.gif`... `image-25.gif` and include them on a page named `image.html`.
