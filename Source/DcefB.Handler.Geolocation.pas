(*
  Delphi Multi-tab Chromium Browser Frame

  Unit owner : BccSafe
  QQ: 1262807955
  Email: bccsafe5988@gmail.com
  Web site   : http://www.bccsafe.com
  Repository : https://github.com/bccsafe/DcefBrowser
*)

unit DcefB.Handler.Geolocation;

interface

uses
  WinApi.Windows, System.Classes,
  DcefB.Dcef3.CefLib, DcefB.Events, DcefB.res, DcefB.Utils, DcefB.BaseObject;

type
  TDcefBGeolocationHandler = class(TCefGeolocationHandlerOwn)
  private
    FEvents: IDcefBEvents;
  protected
    function OnRequestGeolocationPermission(const browser: ICefBrowser;
      const requestingUrl: ustring; requestId: Integer;
      const callback: ICefGeolocationCallback): Boolean; override;
    procedure OnCancelGeolocationPermission(const browser: ICefBrowser;
      const requestingUrl: ustring; requestId: Integer); override;
  public
    constructor Create(aDcefBEvents: IDcefBEvents); reintroduce;
    destructor Destroy; override;
  end;

implementation

{ TCustomGeolocationHandler }

constructor TDcefBGeolocationHandler.Create(aDcefBEvents: IDcefBEvents);
begin
  inherited Create;
  FEvents := aDcefBEvents;
end;

destructor TDcefBGeolocationHandler.Destroy;
begin
  FEvents := nil;
  inherited;
end;

procedure TDcefBGeolocationHandler.OnCancelGeolocationPermission
  (const browser: ICefBrowser; const requestingUrl: ustring;
  requestId: Integer);
{ var
  PArgs: PCancelGeolocationPermissionArgs; }
begin
  inherited;
  { New(PArgs);
    PArgs.requestingUrl := @requestingUrl;
    PArgs.requestId := requestId;
    TDcefBUtils.SendMsg(browser, WM_CancelGeolocationPermission, LParam(PArgs));
    Dispose(PArgs); }
  FEvents.doOnCancelGeolocationPermission(browser, requestingUrl, requestId);
end;

function TDcefBGeolocationHandler.OnRequestGeolocationPermission
  (const browser: ICefBrowser; const requestingUrl: ustring; requestId: Integer;
  const callback: ICefGeolocationCallback): Boolean;
{ var
  PArgs: PRequestGeolocationPermissionArgs; }
begin
  { New(PArgs);
    PArgs.requestingUrl := @requestingUrl;
    PArgs.requestId := requestId;
    PArgs.callback := @callback;
    PArgs.Result := False;
    if TDcefBUtils.SendMsg(browser, WM_RequestGeolocationPermission, LParam(PArgs))
    then
    Result := PArgs.Result
    else
    Result := False;
    Dispose(PArgs); }
  Result := False;
  FEvents.doOnRequestGeolocationPermission(browser, requestingUrl, requestId,
    callback, Result);
end;

end.
