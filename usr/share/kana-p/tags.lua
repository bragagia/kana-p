-- Define atag table which hold all screen tags.
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9}, s, layouts[1])
    tags[s][1].name = '1'
    tags[s][2].name = '2'
    tags[s][3].name = '3'
    tags[s][4].name = '4'
    tags[s][5].name = '5'
    tags[s][6].name = '6'
    tags[s][7].name = '7'
    tags[s][8].name = '8'
    tags[s][9].name = '9'
end
