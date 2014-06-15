with Lexer; use Lexer;

with Ada.Text_IO; use Ada.Text_IO;

procedure main is
   Filename   : String := "lexer.adb";
   File       : Ada.Text_IO.File_Type;
   Char       : Character;
begin
   Ada.Text_IO.Open (File => File,
                     Mode => Ada.Text_IO.In_File,
                     Name => Filename);
   loop
--   Char := Lexer.FetchChar;
      if Ada.Text_IO.End_Of_File (File) then
         exit;
      end if;

      Ada.Text_IO.Get (File, Char);
      case Char is
         when 'p' =>
--  "p"
--         Char := Lexer.FetchChar;
            Ada.Text_IO.Get (File, Char);
            case Char is
               when 'a' =>
--  "pa"
--               Char := Lexer.FetchChar;
                  Ada.Text_IO.Get (File, Char);
                  case Char is
                     when 'c' =>
--  "pac"
                        Ada.Text_IO.Get (File, Char);
                        case Char is
                           when 'k' =>
--  "pack"
                              Ada.Text_IO.Get (File, Char);
                              case Char is
                                 when 'a' =>
--  "packa"
                                    Ada.Text_IO.Get (File, Char);
                                    case Char is
                                       when 'g' =>
--  "packag"
                                          Ada.Text_IO.Get (File, Char);
                                          case Char is
                                             when 'e' =>
--  "package"
                                                Put_Line ("<PACKAGE>");
                                                Ada.Text_IO.Get (File, Char);
                                                case Char is
                                                   when ' ' =>
--  "package "
                                                      Ada.Text_IO.Get (File, Char);
                                                      case Char is
                                                         when 'b' =>
--  "package b"
                                                            Ada.Text_IO.Get (File, Char);
                                                            case Char is
                                                               when 'o' =>
--  "package bo"
                                                                  Ada.Text_IO.Get (File, Char);
                                                                  case Char is
                                                                     when 'd' =>
--  "package bod"
                                                                        Ada.Text_IO.Get (File, Char);
                                                                        case Char is
                                                                           when 'y' =>
--  "package body"
                                                                              Put_Line ("<BODY>");
                                                                           when others =>
                                                                              null;
                                                                        end case;
                                                                     when others =>
                                                                        null;
                                                                  end case;
                                                               when others =>
                                                                  null;
                                                            end case;
                                                         when others =>
                                                            null;
                                                      end case;
                                                   when others =>
                                                      null;
                                                end case;
                                             when others =>
                                                null;
                                          end case;
                                       when others =>
                                          null;
                                    end case;
                                 when others =>
                                    null;
                              end case;
                           when others =>
                              null;
                        end case;
                     when others =>
                        null;
                  end case;
               when others =>
                  null;
            end case;
         when others =>
            null;
      end case;
   end loop;

   Ada.Text_IO.Close (File);
end main;
