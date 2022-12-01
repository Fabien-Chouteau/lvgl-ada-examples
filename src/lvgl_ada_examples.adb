with Lv;
with Lv.Tasks;
with Lv.Hal.Tick;

with Test_Theme_1;
with LVGL_Ada_Simulator;

procedure LVGL_Ada_Examples is
begin

   LVGL_Ada_Simulator.Start;
   LVGL_Ada_Simulator.Add_Cursor;

   Test_Theme_1.Init;

   loop
      Lv.Tasks.Handler;
      delay 0.005;
      Lv.Hal.Tick.Inc (5);
   end loop;
end LVGL_Ada_Examples;
