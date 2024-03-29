with Lvgl_Ada_Config;

with Lv; use Lv;
with Lv.Area;
with Lv.Objx; use Lv.Objx;
with Lv.Objx.Cont;
with Lv.Objx.Tabview;
with Lv.Objx.Page;
with Lv.Objx.Btn;
with Lv.Objx.Btnm;
with Lv.Objx.Label;
with Lv.Objx.Switch;
with Lv.Objx.Bar;
with Lv.Objx.Slider;
with Lv.Objx.Line;
with Lv.Objx.Textarea;
with Lv.Objx.Checkbox;
with Lv.Objx.Ddlist;
with Lv.Objx.List;
with Lv.Objx.Roller;
with Lv.Objx.Chart;
with Lv.Objx.Gauge;
with Lv.Objx.Arc;
with Lv.Objx.Keyboard;
with Lv.Objx.Preload;
with Lv.Objx.Win;
with Lv.Objx.Lmeter;
with Lv.Objx.Led;
with Lv.Objx.Calendar;
with Lv.Objx.Mbox;
with Lv.Objx.Canvas;
with Lv.Group;
with Lv.Indev;

with Lv.Color;
with Lv.Theme;
with Lv.Font;
with Lv.Style;

with Lv.Strings; use Lv.Strings;

package body Test_Theme_1 is

   pragma Style_Checks ("M120");
   pragma Warnings (Off, "useless assignment");

   Horizontal_Resolution : constant := Lvgl_Ada_Config.Horizontal_Resolution;
   Vertical_Resolution   : constant := Lvgl_Ada_Config.Vertical_Resolution;
   Density_Per_Inch      : constant := Lvgl_Ada_Config.Density_Per_Inch;

   use type Int16_T;

   Btnm_Str : aliased constant String_Array := (New_String ("1"),
                                                New_String ("2"),
                                                New_String ("3"),
                                                New_String (SYMBOL_OK),
                                                New_String (SYMBOL_CLOSE),
                                                New_String (""));

   Points : aliased constant Lv.Area.Point_Array
     := ((0, 0), (Horizontal_Resolution / 5, 0))
       with Convention => C;

   Theme_Roller : Roller.Instance;

   Keyboard_Group : Lv.Group.Instance;

   procedure Create_Theme_Tab (Parent : Page.Instance);
   procedure Create_Tab1 (Parent : Page.Instance);
   procedure Create_Tab2 (Parent : Page.Instance);
   procedure Create_Tab3 (Parent : Page.Instance);

   procedure Init_Themes (Hue : Lv.Theme.Hue_T);

   function Roller_Action (Arg1 : Obj_T) return Res_T
     with Convention => C;

   function Slider_Action (Arg1 : Obj_T) return Res_T
     with Convention => C;

   procedure Init_Themes (Hue : Lv.Theme.Hue_T) is
      Unused : Lv.Theme.Theme;
   begin
      Unused := Lv.Theme.Default_Init (Hue, Lv.Font.No_Font);
      Unused := Lv.Theme.Material_Init (Hue, Lv.Font.No_Font);
      Unused := Lv.Theme.Mono_Init (Hue, Lv.Font.No_Font);
      Unused := Lv.Theme.Alien_Init (Hue, Lv.Font.No_Font);
      Unused := Lv.Theme.Nemo_Init (Hue, Lv.Font.No_Font);
      Unused := Lv.Theme.Night_Init (Hue, Lv.Font.No_Font);
      Unused := Lv.Theme.Zen_Init (Hue, Lv.Font.No_Font);
   end Init_Themes;

   function Roller_Action (Arg1 : Obj_T) return Res_T is
   begin
      case Roller.Selected (Arg1) is
         when 0       => Lv.Theme.Set_Current (Lv.Theme.Get_Default);
         when 1       => Lv.Theme.Set_Current (Lv.Theme.Get_Material);
         when 2       => Lv.Theme.Set_Current (Lv.Theme.Get_Mono);
         when 3       => Lv.Theme.Set_Current (Lv.Theme.Get_Alien);
         when 4       => Lv.Theme.Set_Current (Lv.Theme.Get_Night);
         when 5       => Lv.Theme.Set_Current (Lv.Theme.Get_Zen);
         when others  => Lv.Theme.Set_Current (Lv.Theme.Get_Nemo);
      end case;

      return Res_Ok;
   end Roller_Action;

   function Slider_Action (Arg1 : Obj_T) return Res_T is
   begin
      Init_Themes (Uint16_T (Slider.Value (Arg1)));
      return Roller_Action (Theme_Roller);
   end Slider_Action;

   procedure Create_Theme_Tab (Parent : Page.Instance) is
      TH  : constant Theme.Theme := Theme.Get_Current;
      pragma Unreferenced (TH);
      Slide : Slider.Instance;
   begin
      Page.Set_Scrl_Layout (Parent, Cont.Layout_Pretty);

      Theme_Roller := Roller.Create (Parent, No_Obj);
      Roller.Set_Options (Theme_Roller, New_String ("Default" & ASCII.LF &
                                           "Material" & ASCII.LF &
                                           "Mono" & ASCII.LF &
                                           "Alien" & ASCII.LF &
                                           "Night" & ASCII.LF &
                                           "Zen" & ASCII.LF &
                                           "Nemo"));
      Roller.Set_Selected (Theme_Roller, 4, 0);
      Roller.Set_Visible_Row_Count (Theme_Roller, 3);
      Roller.Set_Action (Theme_Roller, Roller_Action'Access);

      Slide := Slider.Create (Parent, No_Obj);
      Slider.Set_Action (Slide, Slider_Action'Access);
      Slider.Set_Range (Slide, 0, 360);
      Slider.Set_Value (Slide, 70);

   end Create_Theme_Tab;

   procedure Create_Tab1 (Parent : Page.Instance) is
      TH  : constant Theme.Theme :=  Theme.Get_Current;
      pragma Unreferenced (TH);
      H   : Cont.Instance;
      B   : Btn.Instance;
      Lab : Label.Instance;

      BM    : Btnm.Instance;
      Sw_H  : Cont.Instance;
      S     : Switch.Instance;
      Ba    : Bar.Instance;
      Slide : Slider.Instance;
      L     : Line.Instance;
      TA    : Textarea.Instance;
      Check : Checkbox.Instance;
      Drop  : Ddlist.Instance;
      Lst   : List.Instance;
      L_Btn : Btn.Instance;
      Rol   : Roller.Instance;
   begin
      Page.Set_Scrl_Layout (Parent, Cont.Layout_Pretty);

      H := Cont.Create (Parent, No_Obj);
      Set_Click (H, 0);
      Cont.Set_Fit (H, 1, 1);
      Cont.Set_Layout (H, Cont.Layout_Col_M);

      B := Btn.Create (H, No_Obj);
      Btn.Set_Fit (B, 1, 1);
      Set_Click (B, 0);
      Label.Set_Text (Label.Create (B, No_Obj), New_String ("Button"));

      B := Btn.Create (H, No_Obj);
      Btn.Set_Fit (B, 1, 1);
      Btn.Set_Toggle (B, 1);
      Label.Set_Text (Label.Create (B, No_Obj), New_String ("Toggle"));

      B := Btn.Create (H, No_Obj);
      Btn.Toggle (B);
      Label.Set_Text (Label.Create (B, No_Obj), New_String ("Toggled"));

      B := Btn.Create (H, No_Obj);
      Btn.Set_State (B, Btn.State_Ina);
      Label.Set_Text (Label.Create (B, No_Obj), New_String ("Inactive"));

      Lab := Label.Create (H, No_Obj);
      Label.Set_Text (Lab, New_String ("Primary"));
      --  FIXME: Style
      Lab := Label.Create (H, No_Obj);
      Label.Set_Text (Lab, New_String ("Secondary"));
      --  FIXME: Style
      Lab := Label.Create (H, No_Obj);
      Label.Set_Text (Lab, New_String ("Hint"));
      --  FIXME: Style

      BM := Btnm.Create (H, No_Obj);
      Set_Size (BM, Horizontal_Resolution / 4, 2 * Density_Per_Inch / 3);
      Btnm.Set_Map (BM, To_String_Array_Ptr (Btnm_Str'Access));
      Btnm.Set_Toggle (BM, 1, 3);

      H := Cont.Create (Parent, H);

      Sw_H := Cont.Create (H, No_Obj);
      Cont.Set_Fit (Sw_H, 0, 1);
      Set_Width (Sw_H, Horizontal_Resolution / 4);
      Cont.Set_Layout (Sw_H, Cont.Layout_Pretty);

      S := Switch.Create (Sw_H, No_Obj);
      Switch.Off (S);
      S := Switch.Create (Sw_H, No_Obj);
      Switch.On (S);

      --  FIXME: anim

      Ba := Bar.Create (H, No_Obj);
      Bar.Set_Value (Ba, 70);

      Slide := Slider.Create (H, No_Obj);
      Slider.Set_Value (Slide, 70);

      L := Line.Create (H, No_Obj);
      Line.Set_Points (L, Points'Access, 2);
      --  FIXME: style

      TA := Textarea.Create (H, No_Obj);
      --  FIXME: style
      Textarea.Set_Text (TA, New_String ("Some text"));
      Textarea.Set_One_Line (TA, 1);

      Check := Checkbox.Create (H, No_Obj);

      Check := Checkbox.Create (H, Check);
      Btn.Set_State (Check, Btn.State_Tgl_Rel);

      Drop := Ddlist.Create (H, No_Obj);
      Ddlist.Open (Drop, 0);
      Ddlist.Set_Selected (Drop, 1);

      H := Cont.Create (Parent, H);

      Lst := List.Create (H, No_Obj);

      L_Btn := List.Add (Lst, SYMBOL_GPS'Address, New_String ("GPS"), null);
      Set_Size (L_Btn, Horizontal_Resolution / 4, Vertical_Resolution / 2);
      Btn.Set_Toggle (L_Btn, 1);

      L_Btn := List.Add (Lst, SYMBOL_WIFI'Address, New_String ("WiFi"), null);
      L_Btn := List.Add (Lst, SYMBOL_GPS'Address, New_String ("GPS"), null);
      L_Btn := List.Add (Lst, SYMBOL_AUDIO'Address, New_String ("Audio"), null);
      L_Btn := List.Add (Lst, SYMBOL_VIDEO'Address, New_String ("Video"), null);
      L_Btn := List.Add (Lst, SYMBOL_CALL'Address, New_String ("Call"), null);
      L_Btn := List.Add (Lst, SYMBOL_BELL'Address, New_String ("Bell"), null);
      L_Btn := List.Add (Lst, SYMBOL_FILE'Address, New_String ("File"), null);
      L_Btn := List.Add (Lst, SYMBOL_EDIT'Address, New_String ("Edit"), null);
      L_Btn := List.Add (Lst, SYMBOL_CUT'Address, New_String ("Cut"), null);
      L_Btn := List.Add (Lst, SYMBOL_COPY'Address, New_String ("Copy"), null);

      Rol := Roller.Create (H, No_Obj);
      Roller.Set_Options (Rol, New_String ("Monday" & ASCII.LF &
                                           "Tuesday" & ASCII.LF &
                                           "Wednesday" & ASCII.LF &
                                           "Thursday" & ASCII.LF &
                                           "Friday" & ASCII.LF &
                                           "Saturday" & ASCII.LF &
                                           "Sunday"));
      Roller.Set_Selected (Rol, 1, 0);
      Roller.Set_Visible_Row_Count (Rol, 3);
   end Create_Tab1;

   procedure Create_Tab2 (Parent : Page.Instance) is
      W  : constant Lv.Area.Coord_T := Page.Scrl_Width (Parent);
      Ch : Chart.Instance;
      S1 : Chart.Series;
      G  : Gauge.Instance;
      A  : Arc.Instance;
      TA : Textarea.Instance;
      KB : Keyboard.Instance;
      LD : Preload.Instance;
   begin
      Ch := Chart.Create (Parent, No_Obj);
      Set_Size (Ch, W / 3, Vertical_Resolution / 3);
      Set_Pos (Ch, Density_Per_Inch / 10, Density_Per_Inch / 10);

      S1 := Chart.Add_Series (Ch, Lv.Color.Color_Red);
      Chart.Set_Next (Ch, S1, 30);
      Chart.Set_Next (Ch, S1, 20);
      Chart.Set_Next (Ch, S1, 10);
      Chart.Set_Next (Ch, S1, 12);
      Chart.Set_Next (Ch, S1, 20);
      Chart.Set_Next (Ch, S1, 27);
      Chart.Set_Next (Ch, S1, 35);
      Chart.Set_Next (Ch, S1, 55);
      Chart.Set_Next (Ch, S1, 70);
      Chart.Set_Next (Ch, S1, 75);

      G := Gauge.Create (Parent, No_Obj);
      Gauge.Set_Value (G, 0, 40);
      Set_Size (G, W / 4, W / 4);
      Align (G, Ch, Align_Out_Bottom_Left, 0, Density_Per_Inch / 4);

      A := Arc.Create (Parent, No_Obj);
      Align (A, G, Align_Out_Bottom_Mid, 0, Density_Per_Inch / 8);

      TA := Textarea.Create (Parent, No_Obj);
      Set_Size (TA, W / 3, Vertical_Resolution / 4);
      Align (TA, No_Obj, Align_In_Top_Right, -Density_Per_Inch / 10, Density_Per_Inch / 10);
      Textarea.Set_Cursor_Type (TA, Textarea.Cursor_Block);
      Textarea.Set_Style (TA, Textarea.Style_Sb, Lv.Style.Style_Transp);

      --  Textarea get inputs from keyboard
      Lv.Group.Add_Obj (Keyboard_Group, TA);
      Lv.Group.Focus_Obj (TA);

      KB := Keyboard.Create (Parent, No_Obj);
      Set_Size (KB, 2 * W / 3, Vertical_Resolution / 3);
      Align (KB, TA, Align_Out_Bottom_Right, 0, Density_Per_Inch);
      Keyboard.Set_Textarea (KB, TA);

      LD := Preload.Create (Parent, No_Obj);
      Align (LD, No_Obj, Align_Center, 0, -Density_Per_Inch);
   end Create_Tab2;

   function Win_Close_Action (B : Btn.Instance) return Res_T
     with Convention => C;

   function Win_Close_Action (B : Btn.Instance) return Res_T is
      W      : constant Win.Instance := Win.From_Btn (B);
      Unused : Res_T;
   begin
      Unused := Del (W);
      return Res_Inv;
   end Win_Close_Action;

   Box_Btn_Map : aliased constant String_Array
     := (New_String (Character'Val (16#89#) & ""),
         New_String (Character'Val (16#89#) & "Got it!"),
         New_String (Character'Val (16#89#) & ""),
         New_String (""))
       with Convention => C;

   procedure Create_Tab3 (Parent : Page.Instance) is
      W      : Win.Instance;
      Unused : Btn.Instance;
      L      : Label.Instance;
      Meter  : Lmeter.Instance;

      LED1, LED2 : Led.Instance;
      P      : Page.Instance;

      Cal    : Calendar.Instance;
      Highlighted_days : aliased Calendar.Date_Array :=
        ((2018, 5, 5), (2018, 5, 8));

      Box : Mbox.Instance;
   begin
      --  Create a Window
      W := Win.Create (Parent, No_Obj);
      Unused := Win.Add_Btn (W, SYMBOL_CLOSE'Address, Win_Close_Action'Access);
      Unused := Win.Add_Btn (W, SYMBOL_DOWN'Address, null);
      Set_Size (W, Horizontal_Resolution / 2, Vertical_Resolution / 2);
      Set_Pos (W, Density_Per_Inch / 20, Density_Per_Inch / 20);
      Set_Top (W, 1);

      --  Create a Label in the Window
      L := Label.Create (W, No_Obj);
      Label.Set_Text (L, New_String ("Label in the Window"));

      --  Create a Line meter in the Window
      Meter := Lmeter.Create (W, No_Obj);
      Align (Meter, L, Align_Out_Bottom_Left, 0, Density_Per_Inch / 2);
      Lmeter.Set_Value (Meter, 70);

      --  Create a 2 LEDs in the Window
      LED1 := Led.Create (W, No_Obj);
      Align (LED1, Meter, Align_Out_Right_Mid, Density_Per_Inch / 2, 0);
      Led.On (LED1);

      LED2 := Led.Create (W, No_Obj);
      Align (LED2, LED1, Align_Out_Right_Mid, Density_Per_Inch / 2, 0);
      Led.Off (LED2);

      --  Create a Page
      P := Page.Create (Parent, No_Obj);
      Set_Size (P, Horizontal_Resolution / 3, Vertical_Resolution / 2);
      Set_Top (P, 1);
      Align (P, W, Align_In_Top_Right, Density_Per_Inch, Density_Per_Inch);

      L := Label.Create (P, No_Obj);
      Label.Set_Text (L, New_String ("Lorem ipsum dolor sit amet, repudiare voluptatibus pri cu." & ASCII.CR &
                        "Ei mundi pertinax posidonium eum, cum tempor maiorum at," & ASCII.CR &
                        "mea fuisset assentior ad. Usu cu suas civibus iudicabit." & ASCII.CR &
                        "Eum eu congue tempor facilisi. Tale hinc unum te vim." & ASCII.CR &
                        "Te cum populo animal eruditi, labitur inciderint at nec.\n" & ASCII.CR &
                        "Eius corpora et quo. Everti voluptaria instructior est id," & ASCII.CR &
                        "vel in falli primis. Mea ei porro essent admodum," & ASCII.CR &
                        "his ei malis quodsi, te quis aeterno his." & ASCII.CR &
                        "Qui tritani recusabo reprehendunt ne," & ASCII.CR &
                        "per duis explicari at. Simul mediocritatem mei et."));
      Page.Set_Scrl_Fit (P, 1, 1);

      --  Create a Calendar
      Cal := Calendar.Create (Parent, No_Obj);
      Set_Size (Cal, 5 * Density_Per_Inch / 2, 5 * Density_Per_Inch / 2);
      Align (Cal, P, Align_Out_Right_Top, -Density_Per_Inch / 2, Density_Per_Inch / 3);
      Set_Top (Cal, 1);

      Calendar.Set_Highlighted_Dates (Cal, Highlighted_days'Access, 2);
      Calendar.Set_Today_Date (Cal, Highlighted_days (0)'Access);
      Calendar.Set_Showed_Date (Cal, Highlighted_days (0)'Access);

      Box := Mbox.Create (Parent, No_Obj);
      Mbox.Set_Text (Box, New_String ("Click on the window or the page to bring it to the foreground"));
      Mbox.Add_Btns (Box, To_String_Array_Ptr (Box_Btn_Map'Access), null);
      Set_Top (Box, 1);
   end Create_Tab3;

   Canvas_Width : constant := Horizontal_Resolution / 3;
   Canvas_Height : constant := Vertical_Resolution / 3;
   Canvas_Buffer : array (0 .. (Canvas_Width * Canvas_Height) - 1)
     of Lv.Color.Color_T := (others => Lv.Color.Color_Black);

   procedure Create_Tab4 (Parent : Page.Instance) is
      Can : Canvas.Instance;

      Points : aliased constant Canvas.Poly_Points :=
        ((0, 0), (100, 0), (150, 50), (90, 30), (100, 100), (0, 100));

      Rect : aliased constant Canvas.Rectangle_Points :=
        ((10, 10), (110, 10), (110, 110), (10, 110));
      Triangle : aliased constant Canvas.Triangle_Points :=
        ((Canvas_Width / 2, 0),
         (Canvas_Width - 1, Canvas_Height - 1),
         (0, Canvas_Height - 1));
   begin
      Can := Canvas.Create (Parent, No_Obj);

      Canvas.Set_Buffer (Can,
                         Buf => Canvas_Buffer'Address,
                         W   => Canvas_Width,
                         H   => Canvas_Height,
                         CF  =>  Canvas.LV_IMG_CF_TRUE_COLOR);

      Canvas.Draw_Circle (Can,
                          Canvas_Width / 2, Canvas_Height / 2,
                          20, Lv.Color.Color_Aqua);
      Canvas.Boundary_Fill4 (Can,
                             Canvas_Width / 2, Canvas_Height / 2,
                             Lv.Color.Color_Aqua, Lv.Color.Color_Green);
      Canvas.Draw_Polygon (Can,
                           Points'Unchecked_Access,
                           Points'Length,
                           Lv.Color.Color_Purple);
      Canvas.Draw_Rect (Can,
                        Rect'Unchecked_Access,
                        Lv.Color.Color_Orange);

      Canvas.Draw_Triangle (Can,
                            Triangle'Unchecked_Access,
                            Lv.Color.Color_Silver);
   end Create_Tab4;

   procedure Init (Keyboard_Indev : Lv.Hal.Indev.Indev_T) is
      Scr       : Cont.Instance;
      TV        : Tabview.Instance;
      Theme_Tab : Page.Instance;
      Tab1      : Page.Instance;
      Tab2      : Page.Instance;
      Tab3      : Page.Instance;
      Tab4      : Page.Instance;
   begin
      Init_Themes (220);
      Lv.Theme.Set_Current (Lv.Theme.Get_Night);

      Keyboard_Group := Lv.Group.Create;

      Scr := Cont.Create (No_Obj, No_Obj);
      Scr_Load (Scr);

      TV := Tabview.Create (Scr, No_Obj);
      Set_Size (TV, Horizontal_Resolution, Vertical_Resolution);

      Theme_Tab := Tabview.Add_Tab (TV, New_String ("Theme"));
      Tab1 := Tabview.Add_Tab (TV, New_String ("Tab1"));
      Tab2 := Tabview.Add_Tab (TV, New_String ("Tab2"));
      Tab3 := Tabview.Add_Tab (TV, New_String ("Tab3"));
      Tab4 := Tabview.Add_Tab (TV, New_String ("Canvas"));

      Create_Theme_Tab (Theme_Tab);
      Create_Tab1 (Tab1);
      Create_Tab2 (Tab2);
      Create_Tab3 (Tab3);
      Create_Tab4 (Tab4);

      Lv.Indev.Set_Group (Keyboard_Indev, Keyboard_Group);
   end Init;

end Test_Theme_1;
