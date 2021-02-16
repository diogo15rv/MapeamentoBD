unit ufrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.UI.Intf, FireDAC.VCLUI.Error,
  FireDAC.Stan.Error, FireDAC.VCLUI.Login, FireDAC.VCLUI.Wait,
  FireDAC.Phys.FBDef, FireDAC.Phys.MySQLDef, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Vcl.StdCtrls, Vcl.ExtCtrls, RzButton, RzPanel,
  RzRadGrp, RzBtnEdt, RzEdit, Vcl.Mask, FireDAC.Phys.MySQL, FireDAC.Phys,
  FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Comp.UI, FireDAC.Stan.Intf,
  cxClasses, ControlPrincipal, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Service.Connection;

type
  TForm1 = class(TForm)
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    FDGUIxErrorDialog1: TFDGUIxErrorDialog;
    FDGUIxLoginDialog1: TFDGUIxLoginDialog;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    mseHOST: TRzEdit;
    msePORTA: TRzMaskEdit;
    mseDATABASE: TRzButtonEdit;
    mseUSUARIO: TRzEdit;
    mseSENHA: TRzMaskEdit;
    rbgBancoDados: TRzRadioGroup;
    btnCarregar: TRzButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Label6: TLabel;
    msePESQUISAR: TRzMaskEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    cxGridTabelas: TcxGrid;
    cxGridTabelasDBTableView1: TcxGridDBTableView;
    cxGridTabelasLevel1: TcxGridLevel;
    OpenDialog1: TOpenDialog;
    btnGerar: TRzButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCarregarClick(Sender: TObject);
    procedure mseDATABASEButtonClick(Sender: TObject);
    procedure rbgBancoDadosChanging(Sender: TObject; NewIndex: Integer;
      var AllowChange: Boolean);
    procedure cxGridTabelasDBTableView1DataControllerDataChanged(
      Sender: TObject);
    procedure msePESQUISARKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    ControlPrincipal: TControlPrincipal;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.btnCarregarClick(Sender: TObject);

  procedure ValidarCampo(Campo: TCustomEdit);
  begin
    if Campo.Text = '' then
    begin
      Campo.SetFocus;
      raise Exception.Create('O campo ' + Campo.Name + ' deve ser preenchido!');
    end;
  end;

begin
  ValidarCampo(mseHOST);
  ValidarCampo(msePORTA);
  ValidarCampo(mseUSUARIO);
  ValidarCampo(mseSENHA);
  ValidarCampo(mseDATABASE);

  ControlPrincipal.Host     := mseHOST.Text;
  ControlPrincipal.Porta    := StrToInt(msePORTA.Text);
  ControlPrincipal.Database := mseDATABASE.Text;
  ControlPrincipal.Usuario  := mseUSUARIO.Text;
  ControlPrincipal.Senha    := mseSENHA.Text;

  case rbgBancoDados.ItemIndex of
    0: ControlPrincipal.TipoBD := TBancoDados.bdFirebird;
    1: ControlPrincipal.TipoBD := TBancoDados.bdMySQL;
  end;

  ControlPrincipal.ListarTabelas;
end;


procedure TForm1.cxGridTabelasDBTableView1DataControllerDataChanged(
  Sender: TObject);
begin
  cxGridTabelasDBTableView1.DataController.CreateAllItems(True);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ControlPrincipal.Free;
  Application.Terminate;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ControlPrincipal := TControlPrincipal.Create;
  cxGridTabelasDBTableView1.DataController.DataSource := ControlPrincipal.DataSource;

  rbgBancoDados.ItemIndex := 0;
end;

procedure TForm1.mseDATABASEButtonClick(Sender: TObject);
begin
  OpenDialog1.Execute;
  mseDATABASE.Text := OpenDialog1.FileName;
end;

procedure TForm1.msePESQUISARKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  AItemList: TcxFilterCriteriaItemList;
  I: Integer;
begin
  if msePESQUISAR.Text <> '' then
  begin
    cxGridTabelasDBTableView1.FilterBox.Visible := TcxGridFilterVisible.fvNever;

    cxGridTabelasDBTableView1.DataController.Filter.Active := False;
    with cxGridTabelasDBTableView1.DataController.Filter do
    begin
      BeginUpdate;
      try
        Root.Clear;
        Root.BoolOperatorKind := fboOr;
        Options               := Options + [fcoCaseInsensitive];

        AItemList := Root.AddItemList(fboOr);

        for I := 0 to Pred(cxGridTabelasDBTableView1.ColumnCount) do
          AItemList.AddItem(cxGridTabelasDBTableView1.Columns[I], foLike, '%' + msePESQUISAR.Text + '%',  '%' + msePESQUISAR.Text + '%');
      finally
        EndUpdate;
      end;
      cxGridTabelasDBTableView1.DataController.Filter.Active := True;
    end;
  end
  else
  begin
    cxGridTabelasDBTableView1.DataController.Filter.Root.Clear;
    cxGridTabelasDBTableView1.DataController.Filter.Active := False;
  end;
end;

procedure TForm1.rbgBancoDadosChanging(Sender: TObject; NewIndex: Integer;
  var AllowChange: Boolean);
begin
  if NewIndex = 0 then
  begin
    msePORTA.Text   := '3050';
    mseUSUARIO.Text := 'SYSDBA';
  end;
end;

end.
