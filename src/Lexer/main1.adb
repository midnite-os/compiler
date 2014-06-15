with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Streams.Stream_IO;
procedure main1 is
   Filename          : String := "helloworld.adb";
   File              : Ada.Streams.Stream_IO.File_Type;
   InputStream       : Ada.Streams.Stream_IO.Stream_Access;
   Char              : Character;

   Token             : Unbounded_String;

   TokenFloat        : Boolean;
   TokenInteger      : Boolean;
   TokenNumber       : Boolean;
   TokenIdentifier   : Boolean;
   TokenColon        : Boolean;
   TokenSemicolon    : Boolean;
   TokenString       : Boolean;
   TokenCharacter    : Boolean;
   TokenLeftBracket  : Boolean;
   TokenRightBracket : Boolean;
   TokenPlus         : Boolean;
   TokenMinus        : Boolean;
   TokenComment      : Boolean;
   TokenRange        : Boolean;
   TokenGreaterThan  : Boolean;
   TokenLessThan     : Boolean;
   TokenEquals       : Boolean;
   TokenAssign       : Boolean;
   TokenConcat       : Boolean;
   TokenBooleanOr    : Boolean;
   TokenComma        : Boolean;
   TokenArrow        : Boolean;
begin
   Ada.Streams.Stream_IO.Open (File => File,
                               Mode => Ada.Streams.Stream_IO.In_File,
                               Name => Filename);
   InputStream := Ada.Streams.Stream_IO.Stream(File);

   loop
      Token             := To_Unbounded_String ("");
      TokenNumber       := False;
      TokenFloat        := False;
      TokenInteger      := False;
      TokenIdentifier   := False;
      TokenColon        := False;
      TokenSemicolon    := False;
      TokenCharacter    := False;
      TokenString       := False;
      TokenCharacter    := False;
      TokenLeftBracket  := False;
      TokenRightBracket := False;
      TokenPlus         := False;
      TokenMinus        := False;
      TokenComment      := False;
      TokenRange        := False;
      TokenGreaterThan  := False;
      TokenLessThan     := False;
      TokenEquals       := False;
      TokenAssign       := False;
      TokenBooleanOr    := False;
      TokenConcat       := False;
      TokenComma        := False;

      if Ada.Streams.Stream_IO.End_Of_File (File) then
         exit;
      end if;

      Character'Read (InputStream, Char);

      case Char is
         when Character'Val (39) =>
            Token := To_Unbounded_String (To_String (Token) & Char);
            TokenCharacter := True;
            loop
               if Ada.Streams.Stream_IO.End_Of_File (File) then
                  exit;
               end if;

               Character'Read (InputStream, Char);
               case Char is
                  when Character'Val (39) =>
                     Token := To_Unbounded_String (To_String (Token) & Char);
                     exit;
                  when others =>
                     Token := To_Unbounded_String (To_String (Token) & Char);
               end case;
            end loop;
         when '"' =>
-- test
            Token := To_Unbounded_String (To_String (Token) & Char);
            TokenString := True;
            loop
               if Ada.Streams.Stream_IO.End_Of_File (File) then
                  exit;
               end if;

               Character'Read (InputStream, Char);
               case Char is
                  when '"' =>
                     Token := To_Unbounded_String (To_String (Token) & Char);
                     exit;
                  when others =>
                     Token := To_Unbounded_String (To_String (Token) & Char);
               end case;
            end loop;
         when 'a' .. 'z' |
              'A' .. 'Z' =>
            Token := To_Unbounded_String (To_String (Token) & Char);
            TokenIdentifier := True;
            loop
               if Ada.Streams.Stream_IO.End_Of_File (File) then
                  exit;
               end if;

               Character'Read (InputStream, Char);
               case Char is
                  when 'a' .. 'z' |
                       'A' .. 'Z' |
                       '0' .. '9' |
                       '.' |
                       Character'Val (39) |
                       '_' =>
                     Token := To_Unbounded_String (To_String (Token) & Char);
                  when ' ' |
                       ASCII.LF |
                       ASCII.CR |
                       ';' |
                       ',' |
                       ')' =>
                     exit;
                  when others =>
                     Put_Line ("ERROR 1!");
               end case;

            end loop;
         when '(' =>
            TokenLeftBracket := True;
         when ')' =>
            TokenRightBracket := True;
         when '&' =>
            TokenConcat := True;
--         when '.' =>
         when Character'Val (46) =>
            Character'Read (InputStream, Char);
            case Char is
               when Character'Val (46) =>
                  TokenRange := True;
               when others =>
                  null;
            end case;
         when '+' =>
            TokenPlus := True;
         when ',' =>
            TokenComma := True;
         when '-' =>
            Token := To_Unbounded_String (To_String (Token) & Char);
--            TokenComment := True;
            loop
               if Ada.Streams.Stream_IO.End_Of_File (File) then
                  exit;
               end if;

               Character'Read (InputStream, Char);
               case Char is
                  when ' ' =>
                     TokenMinus := True;
                     exit;              Character'Read (InputStream, Char);
               case Char is
                  when 'a' .. 'z' |
                       'A' .. 'Z' |
                       '0' .. '9' |
                       '.' |
                       '_' =>
                     Token := To_Unbounded_String (To_String (Token) & Char);
                  when ' ' |
                       ASCII.LF |
                       ASCII.CR |
                       ';' |
                       ',' |
                       ')' =>
                     exit;
                  when others =>
                     Put_Line ("ERROR 1!");
               end case;
                  when '-' =>
                     TokenComment := True;
                     Token := To_Unbounded_String (To_String (Token) & Char);
                     loop
                        if Ada.Streams.Stream_IO.End_Of_File (File) then
                           exit;
                        end if;
                        Character'Read (InputStream, Char);
                        if Char = ASCII.LF or
                           Char = ASCII.CR then
                           exit;
                        end if;
                     end loop;
                     exit;
                  when others =>
                     Put_Line ("ERROR 2!");
               end case;
            end loop;
         when ':' =>
            Character'Read (InputStream, Char);
            case Char is
               when '=' =>
                  TokenAssign := True;
               when ' ' =>
                  TokenColon := True;
               when others =>
                  null;
            end case;
         when ';' =>
            TokenSemicolon := True;
         when '>' =>
            TokenGreaterThan := True;
         when '<' =>
            TokenLessThan := True;
         when '=' =>
            TokenEquals := True;
         when '|' =>
            TokenBooleanOr := True;
         when ' ' |
              ASCII.CR |
              ASCII.LF =>
            Token := To_Unbounded_String ("");
         when '0' .. '9' =>
            Token := To_Unbounded_String (To_String (Token) & Char);
            TokenNumber := True;
            loop
               if Ada.Streams.Stream_IO.End_Of_File (File) then
                  exit;
               end if;

               Character'Read (InputStream, Char);
               if Char = ' ' then
                  exit;
               end if;
               if Char = '.' then
                  TokenFloat := True;
               end if;
               if Char = '_' then
                  null;
               end if;
               Token := To_Unbounded_String (To_String (Token) & Char);
            end loop;

            if TokenFloat /= True then
               TokenInteger := True;
            end if;
         when others =>
            Token := To_Unbounded_String (To_String (Token) & Char);
            Put_Line ("ERROR 3! a" & To_String (Token) & "a");
      end case;

      if To_String (Token) = "" then
         if TokenSemicolon = True then
            Put_Line ("<SEMICOLON>");
         end if;
         if TokenColon = True then
            Put_Line ("<COLON>");
         end if;
         if TokenLessThan = True then
            Put_Line ("<LESSTHAN>");
         end if;
         if TokenGreaterThan = True then
            Put_Line ("<GREATERTHAN>");
         end if;
         if TokenPlus = True then
            Put_Line ("<PLUS>");
         end if;
         if TokenEquals = True then
            Put_Line ("<EQUALS>");
         end if;
         if TokenMinus = True then
            Put_Line ("<MINUS>");
         end if;
         if TokenLeftBracket = True then
            Put_Line ("<LEFTBRACKET>");
         end if;
         if TokenRightBracket = True then
            Put_Line ("<RIGHTBRACKET>");
         end if;
         if TokenRange = True then
            Put_Line ("<RANGE>");
         end if;
         if TokenBooleanOr = True then
            Put_Line ("<BOOLEAN_OR>");
         end if;
         if TokenAssign = True then
            Put_Line ("<ASSIGN>");
         end if;
         if TokenConcat = True then
            Put_Line ("<CONCAT>");
         end if;

      elsif To_String (Token) = "begin" or
            To_String (Token) = "body" or
            To_String (Token) = "case" or
            To_String (Token) = "end" or
            To_String (Token) = "exit" or
            To_String (Token) = "function" or
            To_String (Token) = "if" or
            To_String (Token) = "is" or
            To_String (Token) = "loop" or
            To_String (Token) = "null" or
            To_String (Token) = "not" or
            To_String (Token) = "others" or
            To_String (Token) = "package" or
            To_String (Token) = "procedure" or
            To_String (Token) = "return" or
            To_String (Token) = "then" or
            To_String (Token) = "use" or
            To_String (Token) = "when" or
            To_String (Token) = "while" or
            To_String (Token) = "with" then
         Put_Line ("<RESERVEDWORD> - " & To_String (Token));
      else
         if TokenNumber = True then
            if TokenInteger = True then
               Put_Line ("<INTEGER> - " & To_String (Token));
            elsif TokenFloat = True then
               Put_Line ("<FLOAT> - " & To_String (Token));
            end if;
         end if;
         if TokenIdentifier = True then
            Put_Line ("<IDENTIFIER> - " & To_String (Token));
         end if;
         if TokenString = True then
            Put_Line ("<STRING> - " & To_String (Token));
         end if;
         if TokenCharacter = True then
            Put_Line ("<CHARACTER> - " & To_String (Token));
         end if;
      end if;

   end loop;

   Ada.Streams.Stream_IO.Close (File);
end main1;
