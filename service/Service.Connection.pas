unit Service.Connection;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet, SysUtils;

type
  TBancoDados = (bdFirebird, bdMySQL);

  TServiceConnection = class
  private
    FFDConnection: TFDConnection;
    FTipoBD: TBancoDados;
    FSenha: String;
    FDatabase: String;
    FHost: String;
    FUsuario: String;
    FPorta: Integer;
    { private declarations }
  protected
    { protected declarations }
    procedure Conexao;
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;
  published
    { published declarations }
    property FDConnection: TFDConnection read FFDConnection;

    property Host: String        read FHost     write FHost;
    property Porta: Integer      read FPorta    write FPorta;
    property TipoBD: TBancoDados read FTipoBD   write FTipoBD;
    property Database: String    read FDatabase write FDatabase;
    property Usuario: String     read FUsuario  write FUsuario;
    property Senha: String       read FSenha    write FSenha;


  end;

implementation

{ TServiceConnection }

procedure TServiceConnection.Conexao;
begin
  case FTipoBD of
    bdFirebird:
    begin
      FFDConnection.Connected := False;
      FFDConnection.Params.Clear;
      FFDConnection.Params.Add('SERVER=' + FHost + '/' + FPorta.ToString);
      FFDConnection.Params.Add('User_Name=' + FUsuario);
      FFDConnection.Params.Add('Password=' + FSenha);
      FFDConnection.Params.Add('DATABASE=' + FDatabase);
      FFDConnection.Params.Add('DriverID=FB');
      FFDConnection.Params.Add('Protocol=TCPIP');
      FFDConnection.UpdateOptions.LockWait := False; //evita travar em deadlock
      FFDConnection.Connected := True;
    end;
    bdMySQL: ;
  end;
end;

constructor TServiceConnection.Create;
begin
  inherited Create;
  FFDConnection := TFDConnection.Create(nil);
end;

destructor TServiceConnection.Destroy;
begin
  FFDConnection.Close;
  FreeAndNil(FFDConnection);
  inherited Destroy;
end;


end.
