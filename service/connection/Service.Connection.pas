unit Service.Connection;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet;

type

  TServiceConnection = class
  private
    FFDConnection: TFDConnection;
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;
  published
    { published declarations }
    property FDConnection: TFDConnection read FFDConnection write FFDConnection;
  end;

implementation


{ TServiceConnection }

constructor TServiceConnection.Create;
begin
  inherited Create;
end;

destructor TServiceConnection.Destroy;
begin
  inherited Destroy;
end;

end.
