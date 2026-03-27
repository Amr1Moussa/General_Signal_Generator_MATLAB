function varargout = signal_generator(varargin)
% SIGNAL_GENERATOR MATLAB code for signal_generator.fig
% General Signal Generator using GUIDE
% Signal regions are entered iteratively using popup and input dialogs.

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @signal_generator_OpeningFcn, ...
                   'gui_OutputFcn',  @signal_generator_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);

if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before signal_generator is made visible.
function signal_generator_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

% initialize stored signal
handles.t = [];
handles.y = [];

% Main figure color
set(handles.figure1, 'Color', [0.12 0.14 0.18]);

% All static text labels to white
txt = findall(handles.figure1, 'Style', 'text');
set(txt, 'ForegroundColor', [1 1 1]);

% Edit boxes style
set(handles.edit_fs, 'BackgroundColor', [0.20 0.22 0.27], 'ForegroundColor', [1 1 1]);
set(handles.edit_t_start, 'BackgroundColor', [0.20 0.22 0.27], 'ForegroundColor', [1 1 1]);
set(handles.edit_end, 'BackgroundColor', [0.20 0.22 0.27], 'ForegroundColor', [1 1 1]);
set(handles.edit_BPs, 'BackgroundColor', [0.20 0.22 0.27], 'ForegroundColor', [1 1 1]);
set(handles.edit_op_value, 'BackgroundColor', [0.20 0.22 0.27], 'ForegroundColor', [1 1 1]);

% Buttons style
set(handles.Display_Button, 'BackgroundColor', [0.00 0.60 1.00], 'ForegroundColor', [1 1 1]);

btnColor = [0.18 0.50 0.80];
set(handles.Amplitude_Scale, 'BackgroundColor', btnColor, 'ForegroundColor', [1 1 1]);
set(handles.Time_Reversal,   'BackgroundColor', btnColor, 'ForegroundColor', [1 1 1]);
set(handles.Time_Shift,      'BackgroundColor', btnColor, 'ForegroundColor', [1 1 1]);
set(handles.Expand,          'BackgroundColor', btnColor, 'ForegroundColor', [1 1 1]);
set(handles.Compress,        'BackgroundColor', btnColor, 'ForegroundColor', [1 1 1]);

set(handles.Grid_Button,  'BackgroundColor', [0.30 0.30 0.30], 'ForegroundColor', [1 1 1]);
set(handles.Clear_Button, 'BackgroundColor', [0.70 0.30 0.30], 'ForegroundColor', [1 1 1]);
set(handles.Close_Button, 'BackgroundColor', [0.50 0.20 0.20], 'ForegroundColor', [1 1 1]);

guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = signal_generator_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

% INPUT FIELD CALLBACKS
function edit_fs_Callback(hObject, eventdata, handles)

function edit_fs_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject, 'BackgroundColor'), get(0, 'defaultUicontrolBackgroundColor'))
    set(hObject, 'BackgroundColor', 'white');
end


function edit_t_start_Callback(hObject, eventdata, handles)

function edit_t_start_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject, 'BackgroundColor'), get(0, 'defaultUicontrolBackgroundColor'))
    set(hObject, 'BackgroundColor', 'white');
end


function edit_end_Callback(hObject, eventdata, handles)

function edit_end_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject, 'BackgroundColor'), get(0, 'defaultUicontrolBackgroundColor'))
    set(hObject, 'BackgroundColor', 'white');
end


function edit_BPs_Callback(hObject, eventdata, handles)

function edit_BPs_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject, 'BackgroundColor'), get(0, 'defaultUicontrolBackgroundColor'))
    set(hObject, 'BackgroundColor', 'white');
end


function edit_op_value_Callback(hObject, eventdata, handles)

function edit_op_value_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject, 'BackgroundColor'), get(0, 'defaultUicontrolBackgroundColor'))
    set(hObject, 'BackgroundColor', 'white');
end


% DISPLAY BUTTON
function Display_Button_Callback(hObject, eventdata, handles)

% Read main inputs
fs = str2double(get(handles.edit_fs, 'String'));
t_start = str2double(get(handles.edit_t_start, 'String'));
t_end = str2double(get(handles.edit_end, 'String'));
bp = str2num(get(handles.edit_BPs, 'String')); %#ok<ST2NM>

if isempty(bp)
    bp = [];
end

% Validate inputs
if isnan(fs) || isnan(t_start) || isnan(t_end)
    errordlg('Please enter valid numeric values.', 'Input Error');
    return;
end

if fs <= 0
    errordlg('Sampling frequency must be greater than zero.', 'Input Error');
    return;
end

if t_start >= t_end
    errordlg('Start time must be less than end time.', 'Input Error');
    return;
end

bp = sort(bp);

if any(bp <= t_start) || any(bp >= t_end)
    errordlg('Break points must lie strictly between start and end time.', 'Input Error');
    return;
end

% Build time vector
t = t_start : 1/fs : t_end;
regions = [t_start, bp, t_end];
y = zeros(size(t));

% Fill each region iteratively
for i = 1:length(regions)-1
    
    r_start = regions(i);
    r_end = regions(i+1);
    
    if i == length(regions)-1
        idx = (t >= r_start) & (t <= r_end);
    else
        idx = (t >= r_start) & (t < r_end);
    end
    
    [region_signal, ok] = get_region_signal(t(idx), i, r_start, r_end);
    
    if ~ok
        errordlg('Signal generation was cancelled.', 'Cancelled');
        return;
    end
    
    y(idx) = region_signal;
end

% Store generated signal
handles.t = t;
handles.y = y;
guidata(hObject, handles);

% Plot
ax = handles.axes1;

plot(ax, handles.t, handles.y, 'LineWidth', 2);

set(ax, ...
    'Color', [0.08 0.09 0.11], ...
    'XColor', [1 1 1], ...
    'YColor', [1 1 1], ...
    'GridColor', [1 1 1], ...
    'GridAlpha', 0.25, ...
    'XGrid', 'on', ...
    'YGrid', 'on', ...
    'Layer', 'top', ...
    'Box', 'on');

title(ax, 'Generated Signal', 'Color', [1 1 1], 'FontSize', 12);
xlabel(ax, 'Time', 'Color', [1 1 1]);
ylabel(ax, 'Amplitude', 'Color', [1 1 1]);
drawnow;

% OPERATIONS

% --- Amplitude Scale
function Amplitude_Scale_Callback(hObject, eventdata, handles)

if ~signal_exists(handles)
    errordlg('Please generate the signal first.', 'Operation Error');
    return;
end

k = str2double(get(handles.edit_op_value, 'String'));

if isnan(k)
    errordlg('Please enter a valid scaling value.', 'Input Error');
    return;
end

handles.y = k * handles.y;
guidata(hObject, handles);

plot_current_signal(handles, 'Modified Signal');


% --- Time Reversal
function Time_Reversal_Callback(hObject, eventdata, handles)

if ~signal_exists(handles)
    errordlg('Please generate the signal first.', 'Operation Error');
    return;
end

handles.t = -handles.t;
guidata(hObject, handles);

plot_current_signal(handles, 'Modified Signal');


% --- Time Shift
function Time_Shift_Callback(hObject, eventdata, handles)

if ~signal_exists(handles)
    errordlg('Please generate the signal first.', 'Operation Error');
    return;
end

shift_value = str2double(get(handles.edit_op_value, 'String'));

if isnan(shift_value)
    errordlg('Please enter a valid shift value.', 'Input Error');
    return;
end

handles.t = handles.t - shift_value;
guidata(hObject, handles);

plot_current_signal(handles, 'Modified Signal');


% --- Expand
function Expand_Callback(hObject, eventdata, handles)

if ~signal_exists(handles)
    errordlg('Please generate the signal first.', 'Operation Error');
    return;
end

a = str2double(get(handles.edit_op_value, 'String'));

if isnan(a) || a <= 0
    errordlg('Expansion value must be a positive number.', 'Input Error');
    return;
end

handles.t = handles.t / a;
guidata(hObject, handles);

plot_current_signal(handles, 'Modified Signal');


% --- Compress
function Compress_Callback(hObject, eventdata, handles)

if ~signal_exists(handles)
    errordlg('Please generate the signal first.', 'Operation Error');
    return;
end

a = str2double(get(handles.edit_op_value, 'String'));

if isnan(a) || a <= 0
    errordlg('Compression value must be a positive number.', 'Input Error');
    return;
end

handles.t = handles.t * a;
guidata(hObject, handles);

plot_current_signal(handles, 'Modified Signal');


% OTHER BUTTONS
function Grid_Button_Callback(hObject, eventdata, handles)
grid(handles.axes1, 'on');


function Clear_Button_Callback(hObject, eventdata, handles)

% clear plot
cla(handles.axes1);
grid(handles.axes1, 'off');

% clear stored signal
handles.t = [];
handles.y = [];

% clear visible input boxes
set(handles.edit_fs, 'String', '');
set(handles.edit_t_start, 'String', '');
set(handles.edit_end, 'String', '');
set(handles.edit_BPs, 'String', '');
set(handles.edit_op_value, 'String', '');

guidata(hObject, handles);


function Close_Button_Callback(hObject, eventdata, handles)
close(handles.figure1);


% HELPER FUNCTIONS
function ok = signal_exists(handles)
ok = isfield(handles, 't') && isfield(handles, 'y') && ...
     ~isempty(handles.t) && ~isempty(handles.y);


function plot_current_signal(handles, plot_title)
ax = handles.axes1;

plot(ax, handles.t, handles.y, 'LineWidth', 2);

set(ax, ...
    'Color', [0.08 0.09 0.11], ...
    'XColor', [1 1 1], ...
    'YColor', [1 1 1], ...
    'GridColor', [1 1 1], ...
    'GridAlpha', 0.25, ...
    'XGrid', 'on', ...
    'YGrid', 'on', ...
    'Layer', 'top', ...
    'Box', 'on');

title(ax, plot_title, 'Color', [1 1 1], 'FontSize', 12);
xlabel(ax, 'Time', 'Color', [1 1 1]);
ylabel(ax, 'Amplitude', 'Color', [1 1 1]);
drawnow;

function [y_region, ok] = get_region_signal(t_region, region_num, r_start, r_end)

ok = true;
y_region = zeros(size(t_region));

signal_list = {'DC', 'Ramp', 'Polynomial', 'Exponential', 'Sinusoidal'};

[indx, tf] = listdlg( ...
    'PromptString', sprintf('Choose signal type for Region %d: [%.2f , %.2f]', region_num, r_start, r_end), ...
    'SelectionMode', 'single', ...
    'ListString', signal_list, ...
    'ListSize', [160 100]);

if ~tf
    ok = false;
    return;
end

switch indx
    
    case 1   % DC
        answer = inputdlg({'Amplitude:'}, ...
            sprintf('Region %d - DC Parameters', region_num), [1 35]);
        
        if isempty(answer)
            ok = false;
            return;
        end
        
        A = str2double(answer{1});
        
        if isnan(A)
            errordlg('Invalid amplitude value.', 'Input Error');
            ok = false;
            return;
        end
        
        y_region = A * ones(size(t_region));
        
        
    case 2   % Ramp
        answer = inputdlg({'Slope:', 'Intercept:'}, ...
            sprintf('Region %d - Ramp Parameters', region_num), [1 35]);
        
        if isempty(answer)
            ok = false;
            return;
        end
        
        m = str2double(answer{1});
        c = str2double(answer{2});
        
        if isnan(m) || isnan(c)
            errordlg('Invalid slope or intercept value.', 'Input Error');
            ok = false;
            return;
        end
        
        y_region = m * t_region + c;
        
        
    case 3   % Polynomial
        answer = inputdlg({'Amplitude:', 'Power:', 'Intercept:'}, ...
            sprintf('Region %d - Polynomial Parameters', region_num), [1 35]);
        
        if isempty(answer)
            ok = false;
            return;
        end
        
        A = str2double(answer{1});
        p = str2double(answer{2});
        c = str2double(answer{3});
        
        if isnan(A) || isnan(p) || isnan(c)
            errordlg('Invalid polynomial parameters.', 'Input Error');
            ok = false;
            return;
        end
        
        y_region = A * (t_region .^ p) + c;
        
        
    case 4   % Exponential
        answer = inputdlg({'Amplitude:', 'Exponent:'}, ...
            sprintf('Region %d - Exponential Parameters', region_num), [1 35]);
        
        if isempty(answer)
            ok = false;
            return;
        end
        
        A = str2double(answer{1});
        a = str2double(answer{2});
        
        if isnan(A) || isnan(a)
            errordlg('Invalid exponential parameters.', 'Input Error');
            ok = false;
            return;
        end
        
        y_region = A * exp(a * t_region);
        
        
    case 5   % Sinusoidal
        answer = inputdlg({'Amplitude:', 'Frequency:', 'Phase (rad):'}, ...
            sprintf('Region %d - Sinusoidal Parameters', region_num), [1 35]);
        
        if isempty(answer)
            ok = false;
            return;
        end
        
        A = str2double(answer{1});
        f = str2double(answer{2});
        phi = str2double(answer{3});
        
        if isnan(A) || isnan(f) || isnan(phi)
            errordlg('Invalid sinusoidal parameters.', 'Input Error');
            ok = false;
            return;
        end
        
        y_region = A * sin(2 * pi * f * t_region + phi);
end
