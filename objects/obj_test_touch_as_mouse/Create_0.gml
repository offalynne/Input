cell_split = 3;

//grid coords
cell_count = cell_split*cell_split;
cell_w = (room_width  / cell_split);
cell_h = (room_height / cell_split);

//cell state
cell_tapped = undefined;
cell_taps = array_create(cell_count, 0);
cell_active = undefined;