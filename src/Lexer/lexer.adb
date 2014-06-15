-- fsdf

package body Lexer is
   function FetchChar return Character is
      Filename   : String := "lexer.adb";
      File       : Ada.Text_IO.File_Type;
      Char       : Character;
   begin
      Ada.Text_IO.Open (File => File,
                        Mode => Ada.Text_IO.In_File,
                        Name => Filename);
--      while not Ada.Text_IO.End_Of_File (File) loop          
--         begin
            Ada.Text_IO.Get (File, Char);
--         end;
--      end loop;
      Ada.Text_IO.Close (File);

      return Char;
   end FetchChar;
end Lexer;
