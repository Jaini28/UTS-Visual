unit Unit1;

interface

uses
  SysUtils, Classes, ZConnection, ZDataset, DB, Forms, ZAbstractRODataset,
  ZAbstractDataset, ZAbstractConnection;

type
  TForm1 = class(TForm)
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    DataSource1: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.

