randomize();
game_set_speed(60,gamespeed_fps);

fractal_noise = new FractalNoise(180,180,4);
grid_getter = new GridGetter();
grid_getter.GridGetterAddInputGrid(fractal_noise);

width = 160;
height = 100;
x = 80;
y = 20;