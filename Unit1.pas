unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  TPerson = class // базовий клас-предок
 fName: String; // ім'я особи
 Constructor Create (name: String);
Function Info: String; Virtual;
end;
TStud = class (TPerson) // клас-нащадок Студент
 fGr: Integer; // номер групи
 Constructor Create (name: String; gr: Integer);
 Function Info: String; Override;
end;
TProf = class (TPerson) // клас-нащадок Викладач
 fdep: String; // назва кафедри
 Constructor Create (name: String; dep: String);
 Function Info: String; Override;
end;

Const SZL = 10;


var
  Form1: TForm1;
  List: Array[1..SZL] of TPerson; // список осіб
 n: Integer = 0; // початкова кількість осіб у списку

implementation

{$R *.dfm}

Constructor TPerson.Create (name: String);
Begin
fName := name;
end;
Constructor TStud.Create(name: String; gr: Integer);
Begin
Inherited Create(name); // виклик конструктора класу-предка
fGr := gr;
end;
Constructor TProf.Create(name: String; dep: String);
Begin
Inherited Create(name); // виклик конструктора класу-предка
fDep := dep;
end;
Function TPerson.Info: String;
Begin
 Result := fName;
end;
Function TStud.Info: String;
Begin
 Result := fName + ' ФЕІ - ' + IntToStr(fGr);
end;
Function TProf.Info:string;
Begin
 Result := fName + ' Викладач кафедри ' + fDep;
end;


Procedure TForm1.Button1Click (Sender: TObject);
Begin
If n < SZL then
Begin // додаємо особу до списку
 n := n + 1;
 If RadioButton1.Checked then
// Створення об'єкту TStud
 List[n] := TStud.Create(Edit1.Text, StrToInt(Edit2.Text))
 else
// Створення об'єкту TProf
List[n] := TProf.Create(Edit1.Text, Edit2.Text);
// Очищення поля вводу
 Edit1.Text := '';
 Edit2.Text := '';
 Edit1.SetFocus; // курсор ставимо у поле Прізвище
end
else ShowMessage('Список заповнено!');
end;

procedure TForm1.Button2Click(Sender: TObject);
Var i: Integer; // індекс
 st: String; // список
Begin
  For i:=1 to SZL do
 If list[i] <> NIL then
 st := st + list[i].Info + #13;
 ShowMessage(' Список студентів та викладачів' + #13 + st);
end;
end.
End;

end.
