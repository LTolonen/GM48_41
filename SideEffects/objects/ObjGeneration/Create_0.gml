randomize();
game_set_speed(60,gamespeed_fps);

grid_getter = new GridGetter();
grid_getter.GridGetterAddInputGrid(new FractalNoise(180,180,4));
grid_getter.GridGetterAddInputGrid(new FractalNoise(180,180,2,3));

width = 160;
height = 100;
x = 80;
y = 20;