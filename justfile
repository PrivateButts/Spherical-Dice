generate-set:
    mkdir -p ./output
    openscad -p ./case.json -P top -o ./output/case-top.stl case.scad
    openscad -p ./case.json -P bottom -o ./output/case-bottom.stl case.scad
    openscad -p ./generator.json -P d4 -o ./output/d4.stl generator.scad
    openscad -p ./generator.json -P d6 -o ./output/d6.stl generator.scad
    openscad -p ./generator.json -P d8 -o ./output/d8.stl generator.scad
    openscad -p ./generator.json -P d10 -o ./output/d10.stl generator.scad
    openscad -p ./generator.json -P d10s -o ./output/d10s.stl generator.scad
    openscad -p ./generator.json -P d12 -o ./output/d12.stl generator.scad
    openscad -p ./generator.json -P d20 -o ./output/d20.stl generator.scad

generate-case:
    mkdir -p ./output
    openscad -p ./case.json -P top -o ./output/case-top.stl case.scad
    openscad -p ./case.json -P bottom -o ./output/case-bottom.stl case.scad