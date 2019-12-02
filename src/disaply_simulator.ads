with LV_Conf;
with SDL_Display;

package Disaply_Simulator is new SDL_Display (LV_Conf.LV_HOR_RES,
                                              LV_Conf.LV_VER_RES);
