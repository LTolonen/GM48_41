#macro VIEW_WIDTH 320
#macro VIEW_HEIGHT 180
draw_set_color(c_white);
draw_set_font(FontClassified12);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text(x+width/2,y,"Generating World");

var _bar_x0 = x;
var _bar_x1 = x+width;
var _bar_y0 = y+30;
var _bar_y1 = y+70;
var _progress_x = lerp(_bar_x0+1,_bar_x1-2,grid_getter.GridGetterGetProgress());
draw_rectangle(_bar_x0,_bar_y0, _bar_x1-1, _bar_y1-1,false);
draw_set_color(c_black);
draw_rectangle(_bar_x0+1,_bar_y0+1, _bar_x1-2, _bar_y1-2,false);
draw_set_color(c_red);
draw_rectangle(_bar_x0+1,_bar_y0+1, _progress_x, _bar_y1-2,false);

