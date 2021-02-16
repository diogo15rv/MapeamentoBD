unit Service.Mapear;

interface

uses Service.Connection, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  SysUtils, Model.Tabelas, Model.Campos;

type

  TServiceMapear = class(TServiceConnection)
  private
    { private declarations }
    FFDMetaInfo: TFDMetaInfoQuery;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;

    function MapearTabelas: TModelTabelas;
    function MapearCampos(Tabela: TTabelas): TModelCampos;
  end;

implementation



{ TServiceMapear }

constructor TServiceMapear.Create;
begin
  inherited Create;
  FFDMetaInfo := TFDMetaInfoQuery.Create(nil);
  FFDMetaInfo.Connection := FDConnection;
end;

destructor TServiceMapear.Destroy;
begin
  FFDMetaInfo.Close;
  FreeAndNil(FFDMetaInfo);
  inherited Destroy;
end;

function TServiceMapear.MapearCampos(Tabela: TTabelas): TModelCampos;

  function PreencheCampo: TCampos;
  begin
    Result := TCampos.Create;
    Result.Nome := FFDMetaInfo.FieldByName('COLUMN_NAME').AsString;
    Result.Tipo := TFDDataType(FFDMetaInfo.FieldByName('COLUMN_DATATYPE').AsInteger);
  end;

begin
  Result := TModelCampos.Create;

  if not FDConnection.Connected then
    Conexao;

  FFDMetaInfo.Active := False;
  FFDMetaInfo.MetaInfoKind := mkTableFields;
  FFDMetaInfo.ObjectName   := Tabela.Nome;
  FFDMetaInfo.Active := True;

  FFDMetaInfo.First;
  while not FFDMetaInfo.Eof do
  begin
    Result.ListaCampos.Add(PreencheCampo);
    FFDMetaInfo.Next;
  end;
end;

function TServiceMapear.MapearTabelas: TModelTabelas;

   function PreencheTabela: TTabelas;
   begin
     Result      := TTabelas.Create;
     Result.Nome := FFDMetaInfo.FieldByName('TABLE_NAME').AsString;
   end;

begin
  Result := TModelTabelas.Create;

  if not FDConnection.Connected then
    Conexao;

  FFDMetaInfo.Active := False;
  FFDMetaInfo.MetaInfoKind := mkTables;
  FFDMetaInfo.CatalogName  := Database;
  FFDMetaInfo.Active := True;

  FFDMetaInfo.First;

  while not FFDMetaInfo.Eof do
  begin
    Result.Lista.Add(PreencheTabela);

    FFDMetaInfo.Next;
  end;
end;

end.
