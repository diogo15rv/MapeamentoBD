object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 261
  ClientWidth = 1157
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 393
    Height = 255
    Align = alLeft
    Caption = 'Conex'#227'o'
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 14
      Width = 22
      Height = 13
      Caption = 'Host'
    end
    object Label2: TLabel
      Left = 191
      Top = 14
      Width = 26
      Height = 13
      Caption = 'Porta'
    end
    object Label3: TLabel
      Left = 8
      Top = 54
      Width = 46
      Height = 13
      Caption = 'Database'
    end
    object Label4: TLabel
      Left = 8
      Top = 94
      Width = 36
      Height = 13
      Caption = 'Usu'#225'rio'
    end
    object Label5: TLabel
      Left = 191
      Top = 94
      Width = 30
      Height = 13
      Caption = 'Senha'
    end
    object mseHOST: TRzEdit
      Left = 8
      Top = 28
      Width = 177
      Height = 21
      Text = ''
      TabOrder = 0
    end
    object msePORTA: TRzMaskEdit
      Left = 191
      Top = 28
      Width = 74
      Height = 21
      TabOrder = 1
      Text = ''
    end
    object mseDATABASE: TRzButtonEdit
      Left = 8
      Top = 68
      Width = 369
      Height = 21
      Text = 'M:\MaxxSoft\Banco de dados\MAXXRURAL.FDB'
      TabOrder = 2
      ButtonKind = bkFolder
      AltBtnWidth = 15
      ButtonWidth = 25
      OnButtonClick = mseDATABASEButtonClick
    end
    object mseUSUARIO: TRzEdit
      Left = 8
      Top = 108
      Width = 177
      Height = 21
      Text = ''
      TabOrder = 3
    end
    object mseSENHA: TRzMaskEdit
      Left = 191
      Top = 108
      Width = 186
      Height = 21
      PasswordChar = '*'
      TabOrder = 4
      Text = ''
    end
    object rbgBancoDados: TRzRadioGroup
      Left = 8
      Top = 135
      Width = 369
      Height = 66
      Caption = 'Banco de dados'
      ItemHeight = 25
      Items.Strings = (
        'Firebird'
        'MySQL')
      TabOrder = 5
      OnChanging = rbgBancoDadosChanging
    end
    object btnCarregar: TRzButton
      Left = 3
      Top = 223
      Caption = 'Carregar'
      TabOrder = 6
      OnClick = btnCarregarClick
    end
    object btnGerar: TRzButton
      Left = 302
      Top = 223
      Caption = 'Gerar'
      TabOrder = 7
    end
  end
  object Panel1: TPanel
    Left = 399
    Top = 0
    Width = 758
    Height = 261
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Panel2: TPanel
      Left = 0
      Top = 210
      Width = 758
      Height = 51
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object Label6: TLabel
        Left = 4
        Top = 4
        Width = 46
        Height = 13
        Caption = 'Pesquisar'
      end
      object msePESQUISAR: TRzMaskEdit
        Left = 4
        Top = 18
        Width = 293
        Height = 21
        TabOrder = 0
        Text = ''
        OnKeyUp = msePESQUISARKeyUp
      end
      object btnMarcar: TButton
        Left = 331
        Top = 16
        Width = 100
        Height = 25
        Caption = 'Marcar'
        TabOrder = 1
      end
      object btnDesmarcar: TButton
        Left = 437
        Top = 16
        Width = 100
        Height = 25
        Caption = 'Desmarcar'
        TabOrder = 2
      end
      object btnMarcarTodos: TButton
        Left = 543
        Top = 16
        Width = 100
        Height = 25
        Caption = 'Marcar todos'
        TabOrder = 3
      end
      object btnDesmarcarTodos: TButton
        Left = 649
        Top = 16
        Width = 100
        Height = 25
        Caption = 'Desmarcar todos'
        TabOrder = 4
      end
    end
    object cxGridTabelas: TcxGrid
      Left = 0
      Top = 0
      Width = 758
      Height = 210
      Align = alClient
      TabOrder = 1
      object cxGridTabelasDBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        DataController.OnDataChanged = cxGridTabelasDBTableView1DataControllerDataChanged
        OptionsSelection.CellSelect = False
        OptionsSelection.MultiSelect = True
        OptionsView.GridLines = glNone
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Content = cxStyle1
        Styles.ContentEven = cxStyle2
      end
      object cxGridTabelasLevel1: TcxGridLevel
        GridView = cxGridTabelasDBTableView1
      end
    end
  end
  object cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = 16768443
    end
    object cxStyle2: TcxStyle
    end
  end
  object FDGUIxErrorDialog1: TFDGUIxErrorDialog
    Provider = 'Forms'
    Left = 1008
    Top = 416
  end
  object FDGUIxLoginDialog1: TFDGUIxLoginDialog
    Provider = 'Forms'
    Left = 888
    Top = 416
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 888
    Top = 464
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 888
    Top = 512
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 1008
    Top = 464
  end
  object OpenDialog1: TOpenDialog
    Left = 1008
    Top = 512
  end
end
