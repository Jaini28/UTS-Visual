unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DBCtrls, Data.DB;

type
  TForm2 = class(TForm)
    edtNama: TEdit;
    edtDiskripsi: TEdit;
    btnSimpan: TButton;
    btnEdit: TButton;
    btnHapus: TButton;
    btnBatal: TButton;
    dbgrd1: TDBGrid;
    lblNama: TLabel;
    lblDiskripsi: TLabel;
    procedure btnSimpanClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnHapusClick(Sender: TObject);
    procedure btnBatalClick(Sender: TObject);
    procedure dbgrd1CellClick(Column: TColumn);
  private
    { Private declarations }
    selectedID: Integer;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses
  Unit1;

{$R *.dfm}

procedure TForm2.btnSimpanClick(Sender: TObject);
begin
  if Form1.ZConnection1.Connected then
  begin
    try
      Form1.ZQuery1.SQL.Clear;
      Form1.ZQuery1.SQL.Add('INSERT INTO satuan (nama, diskripsi) VALUES (:nama, :diskripsi)');
      Form1.ZQuery1.ParamByName('nama').AsString := edtNama.Text;
      Form1.ZQuery1.ParamByName('diskripsi').AsString := edtDiskripsi.Text;
      Form1.ZQuery1.ExecSQL;

      Form1.ZQuery1.SQL.Clear;
      Form1.ZQuery1.SQL.Add('SELECT * FROM satuan');
      Form1.ZQuery1.Open;
      ShowMessage('Data Berhasil Disimpan!');
    except
      on E: Exception do
        ShowMessage('Error saat menyimpan data: ' + E.Message);
    end;
  end
  else
    ShowMessage('Koneksi ke database tidak berhasil.');
end;

procedure TForm2.btnEditClick(Sender: TObject);
begin
  if selectedID <> 0 then
  begin
    try
      Form1.ZQuery1.SQL.Clear;
      Form1.ZQuery1.SQL.Add('UPDATE satuan SET nama = :nama, diskripsi = :diskripsi WHERE id = :id');
      Form1.ZQuery1.ParamByName('nama').AsString := edtNama.Text;
      Form1.ZQuery1.ParamByName('diskripsi').AsString := edtDiskripsi.Text;
      Form1.ZQuery1.ParamByName('id').AsInteger := selectedID;
      Form1.ZQuery1.ExecSQL;

      Form1.ZQuery1.SQL.Clear;
      Form1.ZQuery1.SQL.Add('SELECT * FROM satuan');
      Form1.ZQuery1.Open;
      ShowMessage('Data Berhasil Diupdate!');
    except
      on E: Exception do
        ShowMessage('Error saat mengupdate data: ' + E.Message);
    end;
  end
  else
    ShowMessage('Pilih data yang akan diedit terlebih dahulu.');
end;

procedure TForm2.btnHapusClick(Sender: TObject);
begin
  if selectedID <> 0 then
  begin
    try
      Form1.ZQuery1.SQL.Clear;
      Form1.ZQuery1.SQL.Add('DELETE FROM satuan WHERE id = :id');
      Form1.ZQuery1.ParamByName('id').AsInteger := selectedID;
      Form1.ZQuery1.ExecSQL;

      Form1.ZQuery1.SQL.Clear;
      Form1.ZQuery1.SQL.Add('SELECT * FROM satuan');
      Form1.ZQuery1.Open;
      ShowMessage('Data Berhasil Dihapus!');
    except
      on E: Exception do
        ShowMessage('Error saat menghapus data: ' + E.Message);
    end;
  end
  else
    ShowMessage('Pilih data yang akan dihapus terlebih dahulu.');
end;

procedure TForm2.btnBatalClick(Sender: TObject);
begin
  edtNama.Clear;
  edtDiskripsi.Clear;
  selectedID := 0;
end;

procedure TForm2.dbgrd1CellClick(Column: TColumn);
begin
  if not Form1.ZQuery1.IsEmpty then
  begin
    selectedID := Form1.ZQuery1.FieldByName('id').AsInteger;
    ShowMessage('Selected ID: ' + IntToStr(selectedID)); // Debugging: Memastikan selectedID benar
    edtNama.Text := Form1.ZQuery1.FieldByName('nama').AsString;
    edtDiskripsi.Text := Form1.ZQuery1.FieldByName('diskripsi').AsString;
  end
  else
    ShowMessage('Tidak ada data yang dipilih.');
end;

end.

