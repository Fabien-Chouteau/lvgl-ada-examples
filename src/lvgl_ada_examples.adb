with Lv;
with Lv.Tasks;
with Lv.Hal.Tick;

with Test_Theme_1;
with LVGL_Ada_Simulator;

procedure LVGL_Ada_Examples is
begin

   LVGL_Ada_Simulator.Start ("LVLG Ada Examples", 60);
   LVGL_Ada_Simulator.Add_Pointer (With_Cursor => True);
   LVGL_Ada_Simulator.Add_Keyboard;

   Test_Theme_1.Init (LVGL_Ada_Simulator.Keyboard_Indev);

   loop
      Lv.Tasks.Handler;
      delay 0.005;
      Lv.Hal.Tick.Inc (5);
   end loop;
end LVGL_Ada_Examples;
