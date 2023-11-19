module Raylib
const dir = dirname(@__DIR__)
const raylib = dir * "/artifacts/libraylib.so.5.0.0"
using CEnum

struct Color
    r::Cuchar
    g::Cuchar
    b::Cuchar
    a::Cuchar
end

struct Vector2
    x::Cfloat
    y::Cfloat
end

struct Vector3
    x::Cfloat
    y::Cfloat
    z::Cfloat
end

struct Vector4
    x::Cfloat
    y::Cfloat
    z::Cfloat
    w::Cfloat
end

const Quaternion = Vector4

struct Matrix
    m0::Cfloat
    m4::Cfloat
    m8::Cfloat
    m12::Cfloat
    m1::Cfloat
    m5::Cfloat
    m9::Cfloat
    m13::Cfloat
    m2::Cfloat
    m6::Cfloat
    m10::Cfloat
    m14::Cfloat
    m3::Cfloat
    m7::Cfloat
    m11::Cfloat
    m15::Cfloat
end

struct Rectangle
    x::Cfloat
    y::Cfloat
    width::Cfloat
    height::Cfloat
end

struct Image
    data::Ptr{Cvoid}
    width::Cint
    height::Cint
    mipmaps::Cint
    format::Cint
end

struct Texture
    id::Cuint
    width::Cint
    height::Cint
    mipmaps::Cint
    format::Cint
end

const Texture2D = Texture

const TextureCubemap = Texture

struct RenderTexture
    id::Cuint
    texture::Texture
    depth::Texture
end

const RenderTexture2D = RenderTexture

struct NPatchInfo
    source::Rectangle
    left::Cint
    top::Cint
    right::Cint
    bottom::Cint
    layout::Cint
end

struct GlyphInfo
    value::Cint
    offsetX::Cint
    offsetY::Cint
    advanceX::Cint
    image::Image
end

struct Font
    baseSize::Cint
    glyphCount::Cint
    glyphPadding::Cint
    texture::Texture2D
    recs::Ptr{Rectangle}
    glyphs::Ptr{GlyphInfo}
end

struct Camera3D
    position::Vector3
    target::Vector3
    up::Vector3
    fovy::Cfloat
    projection::Cint
end

const Camera = Camera3D

struct Camera2D
    offset::Vector2
    target::Vector2
    rotation::Cfloat
    zoom::Cfloat
end

struct Mesh
    vertexCount::Cint
    triangleCount::Cint
    vertices::Ptr{Cfloat}
    texcoords::Ptr{Cfloat}
    texcoords2::Ptr{Cfloat}
    normals::Ptr{Cfloat}
    tangents::Ptr{Cfloat}
    colors::Ptr{Cuchar}
    indices::Ptr{Cushort}
    animVertices::Ptr{Cfloat}
    animNormals::Ptr{Cfloat}
    boneIds::Ptr{Cuchar}
    boneWeights::Ptr{Cfloat}
    vaoId::Cuint
    vboId::Ptr{Cuint}
end

struct Shader
    id::Cuint
    locs::Ptr{Cint}
end

struct MaterialMap
    texture::Texture2D
    color::Color
    value::Cfloat
end

struct Material
    shader::Shader
    maps::Ptr{MaterialMap}
    params::NTuple{4, Cfloat}
end

struct Transform
    translation::Vector3
    rotation::Quaternion
    scale::Vector3
end

struct BoneInfo
    name::NTuple{32, Cchar}
    parent::Cint
end

struct Model
    transform::Matrix
    meshCount::Cint
    materialCount::Cint
    meshes::Ptr{Mesh}
    materials::Ptr{Material}
    meshMaterial::Ptr{Cint}
    boneCount::Cint
    bones::Ptr{BoneInfo}
    bindPose::Ptr{Transform}
end

struct ModelAnimation
    boneCount::Cint
    frameCount::Cint
    bones::Ptr{BoneInfo}
    framePoses::Ptr{Ptr{Transform}}
    name::NTuple{32, Cchar}
end

struct Ray
    position::Vector3
    direction::Vector3
end

struct RayCollision
    hit::Bool
    distance::Cfloat
    point::Vector3
    normal::Vector3
end

struct BoundingBox
    min::Vector3
    max::Vector3
end

struct Wave
    frameCount::Cuint
    sampleRate::Cuint
    sampleSize::Cuint
    channels::Cuint
    data::Ptr{Cvoid}
end

mutable struct rAudioBuffer end

mutable struct rAudioProcessor end

struct AudioStream
    buffer::Ptr{rAudioBuffer}
    processor::Ptr{rAudioProcessor}
    sampleRate::Cuint
    sampleSize::Cuint
    channels::Cuint
end

struct Sound
    stream::AudioStream
    frameCount::Cuint
end

struct Music
    stream::AudioStream
    frameCount::Cuint
    looping::Bool
    ctxType::Cint
    ctxData::Ptr{Cvoid}
end

struct VrDeviceInfo
    hResolution::Cint
    vResolution::Cint
    hScreenSize::Cfloat
    vScreenSize::Cfloat
    vScreenCenter::Cfloat
    eyeToScreenDistance::Cfloat
    lensSeparationDistance::Cfloat
    interpupillaryDistance::Cfloat
    lensDistortionValues::NTuple{4, Cfloat}
    chromaAbCorrection::NTuple{4, Cfloat}
end

struct VrStereoConfig
    projection::NTuple{2, Matrix}
    viewOffset::NTuple{2, Matrix}
    leftLensCenter::NTuple{2, Cfloat}
    rightLensCenter::NTuple{2, Cfloat}
    leftScreenCenter::NTuple{2, Cfloat}
    rightScreenCenter::NTuple{2, Cfloat}
    scale::NTuple{2, Cfloat}
    scaleIn::NTuple{2, Cfloat}
end

struct FilePathList
    capacity::Cuint
    count::Cuint
    paths::Ptr{Ptr{Cchar}}
end

struct AutomationEvent
    frame::Cuint
    type::Cuint
    params::NTuple{4, Cint}
end

struct AutomationEventList
    capacity::Cuint
    count::Cuint
    events::Ptr{AutomationEvent}
end

@cenum ConfigFlags::UInt32 begin
    FLAG_VSYNC_HINT = 64
    FLAG_FULLSCREEN_MODE = 2
    FLAG_WINDOW_RESIZABLE = 4
    FLAG_WINDOW_UNDECORATED = 8
    FLAG_WINDOW_HIDDEN = 128
    FLAG_WINDOW_MINIMIZED = 512
    FLAG_WINDOW_MAXIMIZED = 1024
    FLAG_WINDOW_UNFOCUSED = 2048
    FLAG_WINDOW_TOPMOST = 4096
    FLAG_WINDOW_ALWAYS_RUN = 256
    FLAG_WINDOW_TRANSPARENT = 16
    FLAG_WINDOW_HIGHDPI = 8192
    FLAG_WINDOW_MOUSE_PASSTHROUGH = 16384
    FLAG_BORDERLESS_WINDOWED_MODE = 32768
    FLAG_MSAA_4X_HINT = 32
    FLAG_INTERLACED_HINT = 65536
end

@cenum TraceLogLevel::UInt32 begin
    LOG_ALL = 0
    LOG_TRACE = 1
    LOG_DEBUG = 2
    LOG_INFO = 3
    LOG_WARNING = 4
    LOG_ERROR = 5
    LOG_FATAL = 6
    LOG_NONE = 7
end

@cenum KeyboardKey::UInt32 begin
    KEY_NULL = 0
    KEY_APOSTROPHE = 39
    KEY_COMMA = 44
    KEY_MINUS = 45
    KEY_PERIOD = 46
    KEY_SLASH = 47
    KEY_ZERO = 48
    KEY_ONE = 49
    KEY_TWO = 50
    KEY_THREE = 51
    KEY_FOUR = 52
    KEY_FIVE = 53
    KEY_SIX = 54
    KEY_SEVEN = 55
    KEY_EIGHT = 56
    KEY_NINE = 57
    KEY_SEMICOLON = 59
    KEY_EQUAL = 61
    KEY_A = 65
    KEY_B = 66
    KEY_C = 67
    KEY_D = 68
    KEY_E = 69
    KEY_F = 70
    KEY_G = 71
    KEY_H = 72
    KEY_I = 73
    KEY_J = 74
    KEY_K = 75
    KEY_L = 76
    KEY_M = 77
    KEY_N = 78
    KEY_O = 79
    KEY_P = 80
    KEY_Q = 81
    KEY_R = 82
    KEY_S = 83
    KEY_T = 84
    KEY_U = 85
    KEY_V = 86
    KEY_W = 87
    KEY_X = 88
    KEY_Y = 89
    KEY_Z = 90
    KEY_LEFT_BRACKET = 91
    KEY_BACKSLASH = 92
    KEY_RIGHT_BRACKET = 93
    KEY_GRAVE = 96
    KEY_SPACE = 32
    KEY_ESCAPE = 256
    KEY_ENTER = 257
    KEY_TAB = 258
    KEY_BACKSPACE = 259
    KEY_INSERT = 260
    KEY_DELETE = 261
    KEY_RIGHT = 262
    KEY_LEFT = 263
    KEY_DOWN = 264
    KEY_UP = 265
    KEY_PAGE_UP = 266
    KEY_PAGE_DOWN = 267
    KEY_HOME = 268
    KEY_END = 269
    KEY_CAPS_LOCK = 280
    KEY_SCROLL_LOCK = 281
    KEY_NUM_LOCK = 282
    KEY_PRINT_SCREEN = 283
    KEY_PAUSE = 284
    KEY_F1 = 290
    KEY_F2 = 291
    KEY_F3 = 292
    KEY_F4 = 293
    KEY_F5 = 294
    KEY_F6 = 295
    KEY_F7 = 296
    KEY_F8 = 297
    KEY_F9 = 298
    KEY_F10 = 299
    KEY_F11 = 300
    KEY_F12 = 301
    KEY_LEFT_SHIFT = 340
    KEY_LEFT_CONTROL = 341
    KEY_LEFT_ALT = 342
    KEY_LEFT_SUPER = 343
    KEY_RIGHT_SHIFT = 344
    KEY_RIGHT_CONTROL = 345
    KEY_RIGHT_ALT = 346
    KEY_RIGHT_SUPER = 347
    KEY_KB_MENU = 348
    KEY_KP_0 = 320
    KEY_KP_1 = 321
    KEY_KP_2 = 322
    KEY_KP_3 = 323
    KEY_KP_4 = 324
    KEY_KP_5 = 325
    KEY_KP_6 = 326
    KEY_KP_7 = 327
    KEY_KP_8 = 328
    KEY_KP_9 = 329
    KEY_KP_DECIMAL = 330
    KEY_KP_DIVIDE = 331
    KEY_KP_MULTIPLY = 332
    KEY_KP_SUBTRACT = 333
    KEY_KP_ADD = 334
    KEY_KP_ENTER = 335
    KEY_KP_EQUAL = 336
    KEY_BACK = 4
    KEY_MENU = 82
    KEY_VOLUME_UP = 24
    KEY_VOLUME_DOWN = 25
end

@cenum MouseButton::UInt32 begin
    MOUSE_BUTTON_LEFT = 0
    MOUSE_BUTTON_RIGHT = 1
    MOUSE_BUTTON_MIDDLE = 2
    MOUSE_BUTTON_SIDE = 3
    MOUSE_BUTTON_EXTRA = 4
    MOUSE_BUTTON_FORWARD = 5
    MOUSE_BUTTON_BACK = 6
end

@cenum MouseCursor::UInt32 begin
    MOUSE_CURSOR_DEFAULT = 0
    MOUSE_CURSOR_ARROW = 1
    MOUSE_CURSOR_IBEAM = 2
    MOUSE_CURSOR_CROSSHAIR = 3
    MOUSE_CURSOR_POINTING_HAND = 4
    MOUSE_CURSOR_RESIZE_EW = 5
    MOUSE_CURSOR_RESIZE_NS = 6
    MOUSE_CURSOR_RESIZE_NWSE = 7
    MOUSE_CURSOR_RESIZE_NESW = 8
    MOUSE_CURSOR_RESIZE_ALL = 9
    MOUSE_CURSOR_NOT_ALLOWED = 10
end

@cenum GamepadButton::UInt32 begin
    GAMEPAD_BUTTON_UNKNOWN = 0
    GAMEPAD_BUTTON_LEFT_FACE_UP = 1
    GAMEPAD_BUTTON_LEFT_FACE_RIGHT = 2
    GAMEPAD_BUTTON_LEFT_FACE_DOWN = 3
    GAMEPAD_BUTTON_LEFT_FACE_LEFT = 4
    GAMEPAD_BUTTON_RIGHT_FACE_UP = 5
    GAMEPAD_BUTTON_RIGHT_FACE_RIGHT = 6
    GAMEPAD_BUTTON_RIGHT_FACE_DOWN = 7
    GAMEPAD_BUTTON_RIGHT_FACE_LEFT = 8
    GAMEPAD_BUTTON_LEFT_TRIGGER_1 = 9
    GAMEPAD_BUTTON_LEFT_TRIGGER_2 = 10
    GAMEPAD_BUTTON_RIGHT_TRIGGER_1 = 11
    GAMEPAD_BUTTON_RIGHT_TRIGGER_2 = 12
    GAMEPAD_BUTTON_MIDDLE_LEFT = 13
    GAMEPAD_BUTTON_MIDDLE = 14
    GAMEPAD_BUTTON_MIDDLE_RIGHT = 15
    GAMEPAD_BUTTON_LEFT_THUMB = 16
    GAMEPAD_BUTTON_RIGHT_THUMB = 17
end

@cenum GamepadAxis::UInt32 begin
    GAMEPAD_AXIS_LEFT_X = 0
    GAMEPAD_AXIS_LEFT_Y = 1
    GAMEPAD_AXIS_RIGHT_X = 2
    GAMEPAD_AXIS_RIGHT_Y = 3
    GAMEPAD_AXIS_LEFT_TRIGGER = 4
    GAMEPAD_AXIS_RIGHT_TRIGGER = 5
end

@cenum MaterialMapIndex::UInt32 begin
    MATERIAL_MAP_ALBEDO = 0
    MATERIAL_MAP_METALNESS = 1
    MATERIAL_MAP_NORMAL = 2
    MATERIAL_MAP_ROUGHNESS = 3
    MATERIAL_MAP_OCCLUSION = 4
    MATERIAL_MAP_EMISSION = 5
    MATERIAL_MAP_HEIGHT = 6
    MATERIAL_MAP_CUBEMAP = 7
    MATERIAL_MAP_IRRADIANCE = 8
    MATERIAL_MAP_PREFILTER = 9
    MATERIAL_MAP_BRDF = 10
end

@cenum ShaderLocationIndex::UInt32 begin
    SHADER_LOC_VERTEX_POSITION = 0
    SHADER_LOC_VERTEX_TEXCOORD01 = 1
    SHADER_LOC_VERTEX_TEXCOORD02 = 2
    SHADER_LOC_VERTEX_NORMAL = 3
    SHADER_LOC_VERTEX_TANGENT = 4
    SHADER_LOC_VERTEX_COLOR = 5
    SHADER_LOC_MATRIX_MVP = 6
    SHADER_LOC_MATRIX_VIEW = 7
    SHADER_LOC_MATRIX_PROJECTION = 8
    SHADER_LOC_MATRIX_MODEL = 9
    SHADER_LOC_MATRIX_NORMAL = 10
    SHADER_LOC_VECTOR_VIEW = 11
    SHADER_LOC_COLOR_DIFFUSE = 12
    SHADER_LOC_COLOR_SPECULAR = 13
    SHADER_LOC_COLOR_AMBIENT = 14
    SHADER_LOC_MAP_ALBEDO = 15
    SHADER_LOC_MAP_METALNESS = 16
    SHADER_LOC_MAP_NORMAL = 17
    SHADER_LOC_MAP_ROUGHNESS = 18
    SHADER_LOC_MAP_OCCLUSION = 19
    SHADER_LOC_MAP_EMISSION = 20
    SHADER_LOC_MAP_HEIGHT = 21
    SHADER_LOC_MAP_CUBEMAP = 22
    SHADER_LOC_MAP_IRRADIANCE = 23
    SHADER_LOC_MAP_PREFILTER = 24
    SHADER_LOC_MAP_BRDF = 25
end

@cenum ShaderUniformDataType::UInt32 begin
    SHADER_UNIFORM_FLOAT = 0
    SHADER_UNIFORM_VEC2 = 1
    SHADER_UNIFORM_VEC3 = 2
    SHADER_UNIFORM_VEC4 = 3
    SHADER_UNIFORM_INT = 4
    SHADER_UNIFORM_IVEC2 = 5
    SHADER_UNIFORM_IVEC3 = 6
    SHADER_UNIFORM_IVEC4 = 7
    SHADER_UNIFORM_SAMPLER2D = 8
end

@cenum ShaderAttributeDataType::UInt32 begin
    SHADER_ATTRIB_FLOAT = 0
    SHADER_ATTRIB_VEC2 = 1
    SHADER_ATTRIB_VEC3 = 2
    SHADER_ATTRIB_VEC4 = 3
end

@cenum PixelFormat::UInt32 begin
    PIXELFORMAT_UNCOMPRESSED_GRAYSCALE = 1
    PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA = 2
    PIXELFORMAT_UNCOMPRESSED_R5G6B5 = 3
    PIXELFORMAT_UNCOMPRESSED_R8G8B8 = 4
    PIXELFORMAT_UNCOMPRESSED_R5G5B5A1 = 5
    PIXELFORMAT_UNCOMPRESSED_R4G4B4A4 = 6
    PIXELFORMAT_UNCOMPRESSED_R8G8B8A8 = 7
    PIXELFORMAT_UNCOMPRESSED_R32 = 8
    PIXELFORMAT_UNCOMPRESSED_R32G32B32 = 9
    PIXELFORMAT_UNCOMPRESSED_R32G32B32A32 = 10
    PIXELFORMAT_UNCOMPRESSED_R16 = 11
    PIXELFORMAT_UNCOMPRESSED_R16G16B16 = 12
    PIXELFORMAT_UNCOMPRESSED_R16G16B16A16 = 13
    PIXELFORMAT_COMPRESSED_DXT1_RGB = 14
    PIXELFORMAT_COMPRESSED_DXT1_RGBA = 15
    PIXELFORMAT_COMPRESSED_DXT3_RGBA = 16
    PIXELFORMAT_COMPRESSED_DXT5_RGBA = 17
    PIXELFORMAT_COMPRESSED_ETC1_RGB = 18
    PIXELFORMAT_COMPRESSED_ETC2_RGB = 19
    PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA = 20
    PIXELFORMAT_COMPRESSED_PVRT_RGB = 21
    PIXELFORMAT_COMPRESSED_PVRT_RGBA = 22
    PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA = 23
    PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA = 24
end

@cenum TextureFilter::UInt32 begin
    TEXTURE_FILTER_POINT = 0
    TEXTURE_FILTER_BILINEAR = 1
    TEXTURE_FILTER_TRILINEAR = 2
    TEXTURE_FILTER_ANISOTROPIC_4X = 3
    TEXTURE_FILTER_ANISOTROPIC_8X = 4
    TEXTURE_FILTER_ANISOTROPIC_16X = 5
end

@cenum TextureWrap::UInt32 begin
    TEXTURE_WRAP_REPEAT = 0
    TEXTURE_WRAP_CLAMP = 1
    TEXTURE_WRAP_MIRROR_REPEAT = 2
    TEXTURE_WRAP_MIRROR_CLAMP = 3
end

@cenum CubemapLayout::UInt32 begin
    CUBEMAP_LAYOUT_AUTO_DETECT = 0
    CUBEMAP_LAYOUT_LINE_VERTICAL = 1
    CUBEMAP_LAYOUT_LINE_HORIZONTAL = 2
    CUBEMAP_LAYOUT_CROSS_THREE_BY_FOUR = 3
    CUBEMAP_LAYOUT_CROSS_FOUR_BY_THREE = 4
    CUBEMAP_LAYOUT_PANORAMA = 5
end

@cenum FontType::UInt32 begin
    FONT_DEFAULT = 0
    FONT_BITMAP = 1
    FONT_SDF = 2
end

@cenum BlendMode::UInt32 begin
    BLEND_ALPHA = 0
    BLEND_ADDITIVE = 1
    BLEND_MULTIPLIED = 2
    BLEND_ADD_COLORS = 3
    BLEND_SUBTRACT_COLORS = 4
    BLEND_ALPHA_PREMULTIPLY = 5
    BLEND_CUSTOM = 6
    BLEND_CUSTOM_SEPARATE = 7
end

@cenum Gesture::UInt32 begin
    GESTURE_NONE = 0
    GESTURE_TAP = 1
    GESTURE_DOUBLETAP = 2
    GESTURE_HOLD = 4
    GESTURE_DRAG = 8
    GESTURE_SWIPE_RIGHT = 16
    GESTURE_SWIPE_LEFT = 32
    GESTURE_SWIPE_UP = 64
    GESTURE_SWIPE_DOWN = 128
    GESTURE_PINCH_IN = 256
    GESTURE_PINCH_OUT = 512
end

@cenum CameraMode::UInt32 begin
    CAMERA_CUSTOM = 0
    CAMERA_FREE = 1
    CAMERA_ORBITAL = 2
    CAMERA_FIRST_PERSON = 3
    CAMERA_THIRD_PERSON = 4
end

@cenum CameraProjection::UInt32 begin
    CAMERA_PERSPECTIVE = 0
    CAMERA_ORTHOGRAPHIC = 1
end

@cenum NPatchLayout::UInt32 begin
    NPATCH_NINE_PATCH = 0
    NPATCH_THREE_PATCH_VERTICAL = 1
    NPATCH_THREE_PATCH_HORIZONTAL = 2
end

# typedef void ( * TraceLogCallback ) ( int logLevel , const char * text , va_list args )
const TraceLogCallback = Ptr{Cvoid}

# typedef unsigned char * ( * LoadFileDataCallback ) ( const char * fileName , int * dataSize )
const LoadFileDataCallback = Ptr{Cvoid}

# typedef bool ( * SaveFileDataCallback ) ( const char * fileName , void * data , int dataSize )
const SaveFileDataCallback = Ptr{Cvoid}

# typedef char * ( * LoadFileTextCallback ) ( const char * fileName )
const LoadFileTextCallback = Ptr{Cvoid}

# typedef bool ( * SaveFileTextCallback ) ( const char * fileName , char * text )
const SaveFileTextCallback = Ptr{Cvoid}

function InitWindow(width, height, title)
    ccall((:InitWindow, raylib), Cvoid, (Cint, Cint, Ptr{Cchar}), width, height, title)
end

function CloseWindow()
    ccall((:CloseWindow, raylib), Cvoid, ())
end

function WindowShouldClose()
    ccall((:WindowShouldClose, raylib), Bool, ())
end

function IsWindowReady()
    ccall((:IsWindowReady, raylib), Bool, ())
end

function IsWindowFullscreen()
    ccall((:IsWindowFullscreen, raylib), Bool, ())
end

function IsWindowHidden()
    ccall((:IsWindowHidden, raylib), Bool, ())
end

function IsWindowMinimized()
    ccall((:IsWindowMinimized, raylib), Bool, ())
end

function IsWindowMaximized()
    ccall((:IsWindowMaximized, raylib), Bool, ())
end

function IsWindowFocused()
    ccall((:IsWindowFocused, raylib), Bool, ())
end

function IsWindowResized()
    ccall((:IsWindowResized, raylib), Bool, ())
end

function IsWindowState(flag)
    ccall((:IsWindowState, raylib), Bool, (Cuint,), flag)
end

function SetWindowState(flags)
    ccall((:SetWindowState, raylib), Cvoid, (Cuint,), flags)
end

function ClearWindowState(flags)
    ccall((:ClearWindowState, raylib), Cvoid, (Cuint,), flags)
end

function ToggleFullscreen()
    ccall((:ToggleFullscreen, raylib), Cvoid, ())
end

function ToggleBorderlessWindowed()
    ccall((:ToggleBorderlessWindowed, raylib), Cvoid, ())
end

function MaximizeWindow()
    ccall((:MaximizeWindow, raylib), Cvoid, ())
end

function MinimizeWindow()
    ccall((:MinimizeWindow, raylib), Cvoid, ())
end

function RestoreWindow()
    ccall((:RestoreWindow, raylib), Cvoid, ())
end

function SetWindowIcon(image)
    ccall((:SetWindowIcon, raylib), Cvoid, (Image,), image)
end

function SetWindowIcons(images, count)
    ccall((:SetWindowIcons, raylib), Cvoid, (Ptr{Image}, Cint), images, count)
end

function SetWindowTitle(title)
    ccall((:SetWindowTitle, raylib), Cvoid, (Ptr{Cchar},), title)
end

function SetWindowPosition(x, y)
    ccall((:SetWindowPosition, raylib), Cvoid, (Cint, Cint), x, y)
end

function SetWindowMonitor(monitor)
    ccall((:SetWindowMonitor, raylib), Cvoid, (Cint,), monitor)
end

function SetWindowMinSize(width, height)
    ccall((:SetWindowMinSize, raylib), Cvoid, (Cint, Cint), width, height)
end

function SetWindowMaxSize(width, height)
    ccall((:SetWindowMaxSize, raylib), Cvoid, (Cint, Cint), width, height)
end

function SetWindowSize(width, height)
    ccall((:SetWindowSize, raylib), Cvoid, (Cint, Cint), width, height)
end

function SetWindowOpacity(opacity)
    ccall((:SetWindowOpacity, raylib), Cvoid, (Cfloat,), opacity)
end

function SetWindowFocused()
    ccall((:SetWindowFocused, raylib), Cvoid, ())
end

function GetWindowHandle()
    ccall((:GetWindowHandle, raylib), Ptr{Cvoid}, ())
end

function GetScreenWidth()
    ccall((:GetScreenWidth, raylib), Cint, ())
end

function GetScreenHeight()
    ccall((:GetScreenHeight, raylib), Cint, ())
end

function GetRenderWidth()
    ccall((:GetRenderWidth, raylib), Cint, ())
end

function GetRenderHeight()
    ccall((:GetRenderHeight, raylib), Cint, ())
end

function GetMonitorCount()
    ccall((:GetMonitorCount, raylib), Cint, ())
end

function GetCurrentMonitor()
    ccall((:GetCurrentMonitor, raylib), Cint, ())
end

function GetMonitorPosition(monitor)
    ccall((:GetMonitorPosition, raylib), Vector2, (Cint,), monitor)
end

function GetMonitorWidth(monitor)
    ccall((:GetMonitorWidth, raylib), Cint, (Cint,), monitor)
end

function GetMonitorHeight(monitor)
    ccall((:GetMonitorHeight, raylib), Cint, (Cint,), monitor)
end

function GetMonitorPhysicalWidth(monitor)
    ccall((:GetMonitorPhysicalWidth, raylib), Cint, (Cint,), monitor)
end

function GetMonitorPhysicalHeight(monitor)
    ccall((:GetMonitorPhysicalHeight, raylib), Cint, (Cint,), monitor)
end

function GetMonitorRefreshRate(monitor)
    ccall((:GetMonitorRefreshRate, raylib), Cint, (Cint,), monitor)
end

function GetWindowPosition()
    ccall((:GetWindowPosition, raylib), Vector2, ())
end

function GetWindowScaleDPI()
    ccall((:GetWindowScaleDPI, raylib), Vector2, ())
end

function GetMonitorName(monitor)
    ccall((:GetMonitorName, raylib), Ptr{Cchar}, (Cint,), monitor)
end

function SetClipboardText(text)
    ccall((:SetClipboardText, raylib), Cvoid, (Ptr{Cchar},), text)
end

function GetClipboardText()
    ccall((:GetClipboardText, raylib), Ptr{Cchar}, ())
end

function EnableEventWaiting()
    ccall((:EnableEventWaiting, raylib), Cvoid, ())
end

function DisableEventWaiting()
    ccall((:DisableEventWaiting, raylib), Cvoid, ())
end

function ShowCursor()
    ccall((:ShowCursor, raylib), Cvoid, ())
end

function HideCursor()
    ccall((:HideCursor, raylib), Cvoid, ())
end

function IsCursorHidden()
    ccall((:IsCursorHidden, raylib), Bool, ())
end

function EnableCursor()
    ccall((:EnableCursor, raylib), Cvoid, ())
end

function DisableCursor()
    ccall((:DisableCursor, raylib), Cvoid, ())
end

function IsCursorOnScreen()
    ccall((:IsCursorOnScreen, raylib), Bool, ())
end

function ClearBackground(color)
    ccall((:ClearBackground, raylib), Cvoid, (Color,), color)
end

function BeginDrawing()
    ccall((:BeginDrawing, raylib), Cvoid, ())
end

function EndDrawing()
    ccall((:EndDrawing, raylib), Cvoid, ())
end

function BeginMode2D(camera)
    ccall((:BeginMode2D, raylib), Cvoid, (Camera2D,), camera)
end

function EndMode2D()
    ccall((:EndMode2D, raylib), Cvoid, ())
end

function BeginMode3D(camera)
    ccall((:BeginMode3D, raylib), Cvoid, (Camera3D,), camera)
end

function EndMode3D()
    ccall((:EndMode3D, raylib), Cvoid, ())
end

function BeginTextureMode(target)
    ccall((:BeginTextureMode, raylib), Cvoid, (RenderTexture2D,), target)
end

function EndTextureMode()
    ccall((:EndTextureMode, raylib), Cvoid, ())
end

function BeginShaderMode(shader)
    ccall((:BeginShaderMode, raylib), Cvoid, (Shader,), shader)
end

function EndShaderMode()
    ccall((:EndShaderMode, raylib), Cvoid, ())
end

function BeginBlendMode(mode)
    ccall((:BeginBlendMode, raylib), Cvoid, (Cint,), mode)
end

function EndBlendMode()
    ccall((:EndBlendMode, raylib), Cvoid, ())
end

function BeginScissorMode(x, y, width, height)
    ccall((:BeginScissorMode, raylib), Cvoid, (Cint, Cint, Cint, Cint), x, y, width, height)
end

function EndScissorMode()
    ccall((:EndScissorMode, raylib), Cvoid, ())
end

function BeginVrStereoMode(config)
    ccall((:BeginVrStereoMode, raylib), Cvoid, (VrStereoConfig,), config)
end

function EndVrStereoMode()
    ccall((:EndVrStereoMode, raylib), Cvoid, ())
end

function LoadVrStereoConfig(device)
    ccall((:LoadVrStereoConfig, raylib), VrStereoConfig, (VrDeviceInfo,), device)
end

function UnloadVrStereoConfig(config)
    ccall((:UnloadVrStereoConfig, raylib), Cvoid, (VrStereoConfig,), config)
end

function LoadShader(vsFileName, fsFileName)
    ccall((:LoadShader, raylib), Shader, (Ptr{Cchar}, Ptr{Cchar}), vsFileName, fsFileName)
end

function LoadShaderFromMemory(vsCode, fsCode)
    ccall((:LoadShaderFromMemory, raylib), Shader, (Ptr{Cchar}, Ptr{Cchar}), vsCode, fsCode)
end

function IsShaderReady(shader)
    ccall((:IsShaderReady, raylib), Bool, (Shader,), shader)
end

function GetShaderLocation(shader, uniformName)
    ccall((:GetShaderLocation, raylib), Cint, (Shader, Ptr{Cchar}), shader, uniformName)
end

function GetShaderLocationAttrib(shader, attribName)
    ccall((:GetShaderLocationAttrib, raylib), Cint, (Shader, Ptr{Cchar}), shader, attribName)
end

function SetShaderValue(shader, locIndex, value, uniformType)
    ccall((:SetShaderValue, raylib), Cvoid, (Shader, Cint, Ptr{Cvoid}, Cint), shader, locIndex, value, uniformType)
end

function SetShaderValueV(shader, locIndex, value, uniformType, count)
    ccall((:SetShaderValueV, raylib), Cvoid, (Shader, Cint, Ptr{Cvoid}, Cint, Cint), shader, locIndex, value, uniformType, count)
end

function SetShaderValueMatrix(shader, locIndex, mat)
    ccall((:SetShaderValueMatrix, raylib), Cvoid, (Shader, Cint, Matrix), shader, locIndex, mat)
end

function SetShaderValueTexture(shader, locIndex, texture)
    ccall((:SetShaderValueTexture, raylib), Cvoid, (Shader, Cint, Texture2D), shader, locIndex, texture)
end

function UnloadShader(shader)
    ccall((:UnloadShader, raylib), Cvoid, (Shader,), shader)
end

function GetMouseRay(mousePosition, camera)
    ccall((:GetMouseRay, raylib), Ray, (Vector2, Camera), mousePosition, camera)
end

function GetCameraMatrix(camera)
    ccall((:GetCameraMatrix, raylib), Matrix, (Camera,), camera)
end

function GetCameraMatrix2D(camera)
    ccall((:GetCameraMatrix2D, raylib), Matrix, (Camera2D,), camera)
end

function GetWorldToScreen(position, camera)
    ccall((:GetWorldToScreen, raylib), Vector2, (Vector3, Camera), position, camera)
end

function GetScreenToWorld2D(position, camera)
    ccall((:GetScreenToWorld2D, raylib), Vector2, (Vector2, Camera2D), position, camera)
end

function GetWorldToScreenEx(position, camera, width, height)
    ccall((:GetWorldToScreenEx, raylib), Vector2, (Vector3, Camera, Cint, Cint), position, camera, width, height)
end

function GetWorldToScreen2D(position, camera)
    ccall((:GetWorldToScreen2D, raylib), Vector2, (Vector2, Camera2D), position, camera)
end

function SetTargetFPS(fps)
    ccall((:SetTargetFPS, raylib), Cvoid, (Cint,), fps)
end

function GetFrameTime()
    ccall((:GetFrameTime, raylib), Cfloat, ())
end

function GetTime()
    ccall((:GetTime, raylib), Cdouble, ())
end

function GetFPS()
    ccall((:GetFPS, raylib), Cint, ())
end

function SwapScreenBuffer()
    ccall((:SwapScreenBuffer, raylib), Cvoid, ())
end

function PollInputEvents()
    ccall((:PollInputEvents, raylib), Cvoid, ())
end

function WaitTime(seconds)
    ccall((:WaitTime, raylib), Cvoid, (Cdouble,), seconds)
end

function SetRandomSeed(seed)
    ccall((:SetRandomSeed, raylib), Cvoid, (Cuint,), seed)
end

function GetRandomValue(min, max)
    ccall((:GetRandomValue, raylib), Cint, (Cint, Cint), min, max)
end

function LoadRandomSequence(count, min, max)
    ccall((:LoadRandomSequence, raylib), Ptr{Cint}, (Cuint, Cint, Cint), count, min, max)
end

function UnloadRandomSequence(sequence)
    ccall((:UnloadRandomSequence, raylib), Cvoid, (Ptr{Cint},), sequence)
end

function TakeScreenshot(fileName)
    ccall((:TakeScreenshot, raylib), Cvoid, (Ptr{Cchar},), fileName)
end

function SetConfigFlags(flags)
    ccall((:SetConfigFlags, raylib), Cvoid, (Cuint,), flags)
end

function OpenURL(url)
    ccall((:OpenURL, raylib), Cvoid, (Ptr{Cchar},), url)
end

function SetTraceLogLevel(logLevel)
    ccall((:SetTraceLogLevel, raylib), Cvoid, (Cint,), logLevel)
end

function MemAlloc(size)
    ccall((:MemAlloc, raylib), Ptr{Cvoid}, (Cuint,), size)
end

function MemRealloc(ptr, size)
    ccall((:MemRealloc, raylib), Ptr{Cvoid}, (Ptr{Cvoid}, Cuint), ptr, size)
end

function MemFree(ptr)
    ccall((:MemFree, raylib), Cvoid, (Ptr{Cvoid},), ptr)
end

function SetTraceLogCallback(callback)
    ccall((:SetTraceLogCallback, raylib), Cvoid, (TraceLogCallback,), callback)
end

function SetLoadFileDataCallback(callback)
    ccall((:SetLoadFileDataCallback, raylib), Cvoid, (LoadFileDataCallback,), callback)
end

function SetSaveFileDataCallback(callback)
    ccall((:SetSaveFileDataCallback, raylib), Cvoid, (SaveFileDataCallback,), callback)
end

function SetLoadFileTextCallback(callback)
    ccall((:SetLoadFileTextCallback, raylib), Cvoid, (LoadFileTextCallback,), callback)
end

function SetSaveFileTextCallback(callback)
    ccall((:SetSaveFileTextCallback, raylib), Cvoid, (SaveFileTextCallback,), callback)
end

function LoadFileData(fileName, dataSize)
    ccall((:LoadFileData, raylib), Ptr{Cuchar}, (Ptr{Cchar}, Ptr{Cint}), fileName, dataSize)
end

function UnloadFileData(data)
    ccall((:UnloadFileData, raylib), Cvoid, (Ptr{Cuchar},), data)
end

function SaveFileData(fileName, data, dataSize)
    ccall((:SaveFileData, raylib), Bool, (Ptr{Cchar}, Ptr{Cvoid}, Cint), fileName, data, dataSize)
end

function ExportDataAsCode(data, dataSize, fileName)
    ccall((:ExportDataAsCode, raylib), Bool, (Ptr{Cuchar}, Cint, Ptr{Cchar}), data, dataSize, fileName)
end

function LoadFileText(fileName)
    ccall((:LoadFileText, raylib), Ptr{Cchar}, (Ptr{Cchar},), fileName)
end

function UnloadFileText(text)
    ccall((:UnloadFileText, raylib), Cvoid, (Ptr{Cchar},), text)
end

function SaveFileText(fileName, text)
    ccall((:SaveFileText, raylib), Bool, (Ptr{Cchar}, Ptr{Cchar}), fileName, text)
end

function FileExists(fileName)
    ccall((:FileExists, raylib), Bool, (Ptr{Cchar},), fileName)
end

function DirectoryExists(dirPath)
    ccall((:DirectoryExists, raylib), Bool, (Ptr{Cchar},), dirPath)
end

function IsFileExtension(fileName, ext)
    ccall((:IsFileExtension, raylib), Bool, (Ptr{Cchar}, Ptr{Cchar}), fileName, ext)
end

function GetFileLength(fileName)
    ccall((:GetFileLength, raylib), Cint, (Ptr{Cchar},), fileName)
end

function GetFileExtension(fileName)
    ccall((:GetFileExtension, raylib), Ptr{Cchar}, (Ptr{Cchar},), fileName)
end

function GetFileName(filePath)
    ccall((:GetFileName, raylib), Ptr{Cchar}, (Ptr{Cchar},), filePath)
end

function GetFileNameWithoutExt(filePath)
    ccall((:GetFileNameWithoutExt, raylib), Ptr{Cchar}, (Ptr{Cchar},), filePath)
end

function GetDirectoryPath(filePath)
    ccall((:GetDirectoryPath, raylib), Ptr{Cchar}, (Ptr{Cchar},), filePath)
end

function GetPrevDirectoryPath(dirPath)
    ccall((:GetPrevDirectoryPath, raylib), Ptr{Cchar}, (Ptr{Cchar},), dirPath)
end

function GetWorkingDirectory()
    ccall((:GetWorkingDirectory, raylib), Ptr{Cchar}, ())
end

function GetApplicationDirectory()
    ccall((:GetApplicationDirectory, raylib), Ptr{Cchar}, ())
end

function ChangeDirectory(dir)
    ccall((:ChangeDirectory, raylib), Bool, (Ptr{Cchar},), dir)
end

function IsPathFile(path)
    ccall((:IsPathFile, raylib), Bool, (Ptr{Cchar},), path)
end

function LoadDirectoryFiles(dirPath)
    ccall((:LoadDirectoryFiles, raylib), FilePathList, (Ptr{Cchar},), dirPath)
end

function LoadDirectoryFilesEx(basePath, filter, scanSubdirs)
    ccall((:LoadDirectoryFilesEx, raylib), FilePathList, (Ptr{Cchar}, Ptr{Cchar}, Bool), basePath, filter, scanSubdirs)
end

function UnloadDirectoryFiles(files)
    ccall((:UnloadDirectoryFiles, raylib), Cvoid, (FilePathList,), files)
end

function IsFileDropped()
    ccall((:IsFileDropped, raylib), Bool, ())
end

function LoadDroppedFiles()
    ccall((:LoadDroppedFiles, raylib), FilePathList, ())
end

function UnloadDroppedFiles(files)
    ccall((:UnloadDroppedFiles, raylib), Cvoid, (FilePathList,), files)
end

function GetFileModTime(fileName)
    ccall((:GetFileModTime, raylib), Clong, (Ptr{Cchar},), fileName)
end

function CompressData(data, dataSize, compDataSize)
    ccall((:CompressData, raylib), Ptr{Cuchar}, (Ptr{Cuchar}, Cint, Ptr{Cint}), data, dataSize, compDataSize)
end

function DecompressData(compData, compDataSize, dataSize)
    ccall((:DecompressData, raylib), Ptr{Cuchar}, (Ptr{Cuchar}, Cint, Ptr{Cint}), compData, compDataSize, dataSize)
end

function EncodeDataBase64(data, dataSize, outputSize)
    ccall((:EncodeDataBase64, raylib), Ptr{Cchar}, (Ptr{Cuchar}, Cint, Ptr{Cint}), data, dataSize, outputSize)
end

function DecodeDataBase64(data, outputSize)
    ccall((:DecodeDataBase64, raylib), Ptr{Cuchar}, (Ptr{Cuchar}, Ptr{Cint}), data, outputSize)
end

function LoadAutomationEventList(fileName)
    ccall((:LoadAutomationEventList, raylib), AutomationEventList, (Ptr{Cchar},), fileName)
end

function UnloadAutomationEventList(list)
    ccall((:UnloadAutomationEventList, raylib), Cvoid, (Ptr{AutomationEventList},), list)
end

function ExportAutomationEventList(list, fileName)
    ccall((:ExportAutomationEventList, raylib), Bool, (AutomationEventList, Ptr{Cchar}), list, fileName)
end

function SetAutomationEventList(list)
    ccall((:SetAutomationEventList, raylib), Cvoid, (Ptr{AutomationEventList},), list)
end

function SetAutomationEventBaseFrame(frame)
    ccall((:SetAutomationEventBaseFrame, raylib), Cvoid, (Cint,), frame)
end

function StartAutomationEventRecording()
    ccall((:StartAutomationEventRecording, raylib), Cvoid, ())
end

function StopAutomationEventRecording()
    ccall((:StopAutomationEventRecording, raylib), Cvoid, ())
end

function PlayAutomationEvent(event)
    ccall((:PlayAutomationEvent, raylib), Cvoid, (AutomationEvent,), event)
end

function IsKeyPressed(key)
    ccall((:IsKeyPressed, raylib), Bool, (Cint,), key)
end

function IsKeyPressedRepeat(key)
    ccall((:IsKeyPressedRepeat, raylib), Bool, (Cint,), key)
end

function IsKeyDown(key)
    ccall((:IsKeyDown, raylib), Bool, (Cint,), key)
end

function IsKeyReleased(key)
    ccall((:IsKeyReleased, raylib), Bool, (Cint,), key)
end

function IsKeyUp(key)
    ccall((:IsKeyUp, raylib), Bool, (Cint,), key)
end

function GetKeyPressed()
    ccall((:GetKeyPressed, raylib), Cint, ())
end

function GetCharPressed()
    ccall((:GetCharPressed, raylib), Cint, ())
end

function SetExitKey(key)
    ccall((:SetExitKey, raylib), Cvoid, (Cint,), key)
end

function IsGamepadAvailable(gamepad)
    ccall((:IsGamepadAvailable, raylib), Bool, (Cint,), gamepad)
end

function GetGamepadName(gamepad)
    ccall((:GetGamepadName, raylib), Ptr{Cchar}, (Cint,), gamepad)
end

function IsGamepadButtonPressed(gamepad, button)
    ccall((:IsGamepadButtonPressed, raylib), Bool, (Cint, Cint), gamepad, button)
end

function IsGamepadButtonDown(gamepad, button)
    ccall((:IsGamepadButtonDown, raylib), Bool, (Cint, Cint), gamepad, button)
end

function IsGamepadButtonReleased(gamepad, button)
    ccall((:IsGamepadButtonReleased, raylib), Bool, (Cint, Cint), gamepad, button)
end

function IsGamepadButtonUp(gamepad, button)
    ccall((:IsGamepadButtonUp, raylib), Bool, (Cint, Cint), gamepad, button)
end

function GetGamepadButtonPressed()
    ccall((:GetGamepadButtonPressed, raylib), Cint, ())
end

function GetGamepadAxisCount(gamepad)
    ccall((:GetGamepadAxisCount, raylib), Cint, (Cint,), gamepad)
end

function GetGamepadAxisMovement(gamepad, axis)
    ccall((:GetGamepadAxisMovement, raylib), Cfloat, (Cint, Cint), gamepad, axis)
end

function SetGamepadMappings(mappings)
    ccall((:SetGamepadMappings, raylib), Cint, (Ptr{Cchar},), mappings)
end

function IsMouseButtonPressed(button)
    ccall((:IsMouseButtonPressed, raylib), Bool, (Cint,), button)
end

function IsMouseButtonDown(button)
    ccall((:IsMouseButtonDown, raylib), Bool, (Cint,), button)
end

function IsMouseButtonReleased(button)
    ccall((:IsMouseButtonReleased, raylib), Bool, (Cint,), button)
end

function IsMouseButtonUp(button)
    ccall((:IsMouseButtonUp, raylib), Bool, (Cint,), button)
end

function GetMouseX()
    ccall((:GetMouseX, raylib), Cint, ())
end

function GetMouseY()
    ccall((:GetMouseY, raylib), Cint, ())
end

function GetMousePosition()
    ccall((:GetMousePosition, raylib), Vector2, ())
end

function GetMouseDelta()
    ccall((:GetMouseDelta, raylib), Vector2, ())
end

function SetMousePosition(x, y)
    ccall((:SetMousePosition, raylib), Cvoid, (Cint, Cint), x, y)
end

function SetMouseOffset(offsetX, offsetY)
    ccall((:SetMouseOffset, raylib), Cvoid, (Cint, Cint), offsetX, offsetY)
end

function SetMouseScale(scaleX, scaleY)
    ccall((:SetMouseScale, raylib), Cvoid, (Cfloat, Cfloat), scaleX, scaleY)
end

function GetMouseWheelMove()
    ccall((:GetMouseWheelMove, raylib), Cfloat, ())
end

function GetMouseWheelMoveV()
    ccall((:GetMouseWheelMoveV, raylib), Vector2, ())
end

function SetMouseCursor(cursor)
    ccall((:SetMouseCursor, raylib), Cvoid, (Cint,), cursor)
end

function GetTouchX()
    ccall((:GetTouchX, raylib), Cint, ())
end

function GetTouchY()
    ccall((:GetTouchY, raylib), Cint, ())
end

function GetTouchPosition(index)
    ccall((:GetTouchPosition, raylib), Vector2, (Cint,), index)
end

function GetTouchPointId(index)
    ccall((:GetTouchPointId, raylib), Cint, (Cint,), index)
end

function GetTouchPointCount()
    ccall((:GetTouchPointCount, raylib), Cint, ())
end

function SetGesturesEnabled(flags)
    ccall((:SetGesturesEnabled, raylib), Cvoid, (Cuint,), flags)
end

function IsGestureDetected(gesture)
    ccall((:IsGestureDetected, raylib), Bool, (Cuint,), gesture)
end

function GetGestureDetected()
    ccall((:GetGestureDetected, raylib), Cint, ())
end

function GetGestureHoldDuration()
    ccall((:GetGestureHoldDuration, raylib), Cfloat, ())
end

function GetGestureDragVector()
    ccall((:GetGestureDragVector, raylib), Vector2, ())
end

function GetGestureDragAngle()
    ccall((:GetGestureDragAngle, raylib), Cfloat, ())
end

function GetGesturePinchVector()
    ccall((:GetGesturePinchVector, raylib), Vector2, ())
end

function GetGesturePinchAngle()
    ccall((:GetGesturePinchAngle, raylib), Cfloat, ())
end

function UpdateCamera(camera, mode)
    ccall((:UpdateCamera, raylib), Cvoid, (Ptr{Camera}, Cint), camera, mode)
end

function UpdateCameraPro(camera, movement, rotation, zoom)
    ccall((:UpdateCameraPro, raylib), Cvoid, (Ptr{Camera}, Vector3, Vector3, Cfloat), camera, movement, rotation, zoom)
end

function SetShapesTexture(texture, source)
    ccall((:SetShapesTexture, raylib), Cvoid, (Texture2D, Rectangle), texture, source)
end

function DrawPixel(posX, posY, color)
    ccall((:DrawPixel, raylib), Cvoid, (Cint, Cint, Color), posX, posY, color)
end

function DrawPixelV(position, color)
    ccall((:DrawPixelV, raylib), Cvoid, (Vector2, Color), position, color)
end

function DrawLine(startPosX, startPosY, endPosX, endPosY, color)
    ccall((:DrawLine, raylib), Cvoid, (Cint, Cint, Cint, Cint, Color), startPosX, startPosY, endPosX, endPosY, color)
end

function DrawLineV(startPos, endPos, color)
    ccall((:DrawLineV, raylib), Cvoid, (Vector2, Vector2, Color), startPos, endPos, color)
end

function DrawLineEx(startPos, endPos, thick, color)
    ccall((:DrawLineEx, raylib), Cvoid, (Vector2, Vector2, Cfloat, Color), startPos, endPos, thick, color)
end

function DrawLineStrip(points, pointCount, color)
    ccall((:DrawLineStrip, raylib), Cvoid, (Ptr{Vector2}, Cint, Color), points, pointCount, color)
end

function DrawLineBezier(startPos, endPos, thick, color)
    ccall((:DrawLineBezier, raylib), Cvoid, (Vector2, Vector2, Cfloat, Color), startPos, endPos, thick, color)
end

function DrawCircle(centerX, centerY, radius, color)
    ccall((:DrawCircle, raylib), Cvoid, (Cint, Cint, Cfloat, Color), centerX, centerY, radius, color)
end

function DrawCircleSector(center, radius, startAngle, endAngle, segments, color)
    ccall((:DrawCircleSector, raylib), Cvoid, (Vector2, Cfloat, Cfloat, Cfloat, Cint, Color), center, radius, startAngle, endAngle, segments, color)
end

function DrawCircleSectorLines(center, radius, startAngle, endAngle, segments, color)
    ccall((:DrawCircleSectorLines, raylib), Cvoid, (Vector2, Cfloat, Cfloat, Cfloat, Cint, Color), center, radius, startAngle, endAngle, segments, color)
end

function DrawCircleGradient(centerX, centerY, radius, color1, color2)
    ccall((:DrawCircleGradient, raylib), Cvoid, (Cint, Cint, Cfloat, Color, Color), centerX, centerY, radius, color1, color2)
end

function DrawCircleV(center, radius, color)
    ccall((:DrawCircleV, raylib), Cvoid, (Vector2, Cfloat, Color), center, radius, color)
end

function DrawCircleLines(centerX, centerY, radius, color)
    ccall((:DrawCircleLines, raylib), Cvoid, (Cint, Cint, Cfloat, Color), centerX, centerY, radius, color)
end

function DrawCircleLinesV(center, radius, color)
    ccall((:DrawCircleLinesV, raylib), Cvoid, (Vector2, Cfloat, Color), center, radius, color)
end

function DrawEllipse(centerX, centerY, radiusH, radiusV, color)
    ccall((:DrawEllipse, raylib), Cvoid, (Cint, Cint, Cfloat, Cfloat, Color), centerX, centerY, radiusH, radiusV, color)
end

function DrawEllipseLines(centerX, centerY, radiusH, radiusV, color)
    ccall((:DrawEllipseLines, raylib), Cvoid, (Cint, Cint, Cfloat, Cfloat, Color), centerX, centerY, radiusH, radiusV, color)
end

function DrawRing(center, innerRadius, outerRadius, startAngle, endAngle, segments, color)
    ccall((:DrawRing, raylib), Cvoid, (Vector2, Cfloat, Cfloat, Cfloat, Cfloat, Cint, Color), center, innerRadius, outerRadius, startAngle, endAngle, segments, color)
end

function DrawRingLines(center, innerRadius, outerRadius, startAngle, endAngle, segments, color)
    ccall((:DrawRingLines, raylib), Cvoid, (Vector2, Cfloat, Cfloat, Cfloat, Cfloat, Cint, Color), center, innerRadius, outerRadius, startAngle, endAngle, segments, color)
end

function DrawRectangle(posX, posY, width, height, color)
    ccall((:DrawRectangle, raylib), Cvoid, (Cint, Cint, Cint, Cint, Color), posX, posY, width, height, color)
end

function DrawRectangleV(position, size, color)
    ccall((:DrawRectangleV, raylib), Cvoid, (Vector2, Vector2, Color), position, size, color)
end

function DrawRectangleRec(rec, color)
    ccall((:DrawRectangleRec, raylib), Cvoid, (Rectangle, Color), rec, color)
end

function DrawRectanglePro(rec, origin, rotation, color)
    ccall((:DrawRectanglePro, raylib), Cvoid, (Rectangle, Vector2, Cfloat, Color), rec, origin, rotation, color)
end

function DrawRectangleGradientV(posX, posY, width, height, color1, color2)
    ccall((:DrawRectangleGradientV, raylib), Cvoid, (Cint, Cint, Cint, Cint, Color, Color), posX, posY, width, height, color1, color2)
end

function DrawRectangleGradientH(posX, posY, width, height, color1, color2)
    ccall((:DrawRectangleGradientH, raylib), Cvoid, (Cint, Cint, Cint, Cint, Color, Color), posX, posY, width, height, color1, color2)
end

function DrawRectangleGradientEx(rec, col1, col2, col3, col4)
    ccall((:DrawRectangleGradientEx, raylib), Cvoid, (Rectangle, Color, Color, Color, Color), rec, col1, col2, col3, col4)
end

function DrawRectangleLines(posX, posY, width, height, color)
    ccall((:DrawRectangleLines, raylib), Cvoid, (Cint, Cint, Cint, Cint, Color), posX, posY, width, height, color)
end

function DrawRectangleLinesEx(rec, lineThick, color)
    ccall((:DrawRectangleLinesEx, raylib), Cvoid, (Rectangle, Cfloat, Color), rec, lineThick, color)
end

function DrawRectangleRounded(rec, roundness, segments, color)
    ccall((:DrawRectangleRounded, raylib), Cvoid, (Rectangle, Cfloat, Cint, Color), rec, roundness, segments, color)
end

function DrawRectangleRoundedLines(rec, roundness, segments, lineThick, color)
    ccall((:DrawRectangleRoundedLines, raylib), Cvoid, (Rectangle, Cfloat, Cint, Cfloat, Color), rec, roundness, segments, lineThick, color)
end

function DrawTriangle(v1, v2, v3, color)
    ccall((:DrawTriangle, raylib), Cvoid, (Vector2, Vector2, Vector2, Color), v1, v2, v3, color)
end

function DrawTriangleLines(v1, v2, v3, color)
    ccall((:DrawTriangleLines, raylib), Cvoid, (Vector2, Vector2, Vector2, Color), v1, v2, v3, color)
end

function DrawTriangleFan(points, pointCount, color)
    ccall((:DrawTriangleFan, raylib), Cvoid, (Ptr{Vector2}, Cint, Color), points, pointCount, color)
end

function DrawTriangleStrip(points, pointCount, color)
    ccall((:DrawTriangleStrip, raylib), Cvoid, (Ptr{Vector2}, Cint, Color), points, pointCount, color)
end

function DrawPoly(center, sides, radius, rotation, color)
    ccall((:DrawPoly, raylib), Cvoid, (Vector2, Cint, Cfloat, Cfloat, Color), center, sides, radius, rotation, color)
end

function DrawPolyLines(center, sides, radius, rotation, color)
    ccall((:DrawPolyLines, raylib), Cvoid, (Vector2, Cint, Cfloat, Cfloat, Color), center, sides, radius, rotation, color)
end

function DrawPolyLinesEx(center, sides, radius, rotation, lineThick, color)
    ccall((:DrawPolyLinesEx, raylib), Cvoid, (Vector2, Cint, Cfloat, Cfloat, Cfloat, Color), center, sides, radius, rotation, lineThick, color)
end

function DrawSplineLinear(points, pointCount, thick, color)
    ccall((:DrawSplineLinear, raylib), Cvoid, (Ptr{Vector2}, Cint, Cfloat, Color), points, pointCount, thick, color)
end

function DrawSplineBasis(points, pointCount, thick, color)
    ccall((:DrawSplineBasis, raylib), Cvoid, (Ptr{Vector2}, Cint, Cfloat, Color), points, pointCount, thick, color)
end

function DrawSplineCatmullRom(points, pointCount, thick, color)
    ccall((:DrawSplineCatmullRom, raylib), Cvoid, (Ptr{Vector2}, Cint, Cfloat, Color), points, pointCount, thick, color)
end

function DrawSplineBezierQuadratic(points, pointCount, thick, color)
    ccall((:DrawSplineBezierQuadratic, raylib), Cvoid, (Ptr{Vector2}, Cint, Cfloat, Color), points, pointCount, thick, color)
end

function DrawSplineBezierCubic(points, pointCount, thick, color)
    ccall((:DrawSplineBezierCubic, raylib), Cvoid, (Ptr{Vector2}, Cint, Cfloat, Color), points, pointCount, thick, color)
end

function DrawSplineSegmentLinear(p1, p2, thick, color)
    ccall((:DrawSplineSegmentLinear, raylib), Cvoid, (Vector2, Vector2, Cfloat, Color), p1, p2, thick, color)
end

function DrawSplineSegmentBasis(p1, p2, p3, p4, thick, color)
    ccall((:DrawSplineSegmentBasis, raylib), Cvoid, (Vector2, Vector2, Vector2, Vector2, Cfloat, Color), p1, p2, p3, p4, thick, color)
end

function DrawSplineSegmentCatmullRom(p1, p2, p3, p4, thick, color)
    ccall((:DrawSplineSegmentCatmullRom, raylib), Cvoid, (Vector2, Vector2, Vector2, Vector2, Cfloat, Color), p1, p2, p3, p4, thick, color)
end

function DrawSplineSegmentBezierQuadratic(p1, c2, p3, thick, color)
    ccall((:DrawSplineSegmentBezierQuadratic, raylib), Cvoid, (Vector2, Vector2, Vector2, Cfloat, Color), p1, c2, p3, thick, color)
end

function DrawSplineSegmentBezierCubic(p1, c2, c3, p4, thick, color)
    ccall((:DrawSplineSegmentBezierCubic, raylib), Cvoid, (Vector2, Vector2, Vector2, Vector2, Cfloat, Color), p1, c2, c3, p4, thick, color)
end

function GetSplinePointLinear(startPos, endPos, t)
    ccall((:GetSplinePointLinear, raylib), Vector2, (Vector2, Vector2, Cfloat), startPos, endPos, t)
end

function GetSplinePointBasis(p1, p2, p3, p4, t)
    ccall((:GetSplinePointBasis, raylib), Vector2, (Vector2, Vector2, Vector2, Vector2, Cfloat), p1, p2, p3, p4, t)
end

function GetSplinePointCatmullRom(p1, p2, p3, p4, t)
    ccall((:GetSplinePointCatmullRom, raylib), Vector2, (Vector2, Vector2, Vector2, Vector2, Cfloat), p1, p2, p3, p4, t)
end

function GetSplinePointBezierQuad(p1, c2, p3, t)
    ccall((:GetSplinePointBezierQuad, raylib), Vector2, (Vector2, Vector2, Vector2, Cfloat), p1, c2, p3, t)
end

function GetSplinePointBezierCubic(p1, c2, c3, p4, t)
    ccall((:GetSplinePointBezierCubic, raylib), Vector2, (Vector2, Vector2, Vector2, Vector2, Cfloat), p1, c2, c3, p4, t)
end

function CheckCollisionRecs(rec1, rec2)
    ccall((:CheckCollisionRecs, raylib), Bool, (Rectangle, Rectangle), rec1, rec2)
end

function CheckCollisionCircles(center1, radius1, center2, radius2)
    ccall((:CheckCollisionCircles, raylib), Bool, (Vector2, Cfloat, Vector2, Cfloat), center1, radius1, center2, radius2)
end

function CheckCollisionCircleRec(center, radius, rec)
    ccall((:CheckCollisionCircleRec, raylib), Bool, (Vector2, Cfloat, Rectangle), center, radius, rec)
end

function CheckCollisionPointRec(point, rec)
    ccall((:CheckCollisionPointRec, raylib), Bool, (Vector2, Rectangle), point, rec)
end

function CheckCollisionPointCircle(point, center, radius)
    ccall((:CheckCollisionPointCircle, raylib), Bool, (Vector2, Vector2, Cfloat), point, center, radius)
end

function CheckCollisionPointTriangle(point, p1, p2, p3)
    ccall((:CheckCollisionPointTriangle, raylib), Bool, (Vector2, Vector2, Vector2, Vector2), point, p1, p2, p3)
end

function CheckCollisionPointPoly(point, points, pointCount)
    ccall((:CheckCollisionPointPoly, raylib), Bool, (Vector2, Ptr{Vector2}, Cint), point, points, pointCount)
end

function CheckCollisionLines(startPos1, endPos1, startPos2, endPos2, collisionPoint)
    ccall((:CheckCollisionLines, raylib), Bool, (Vector2, Vector2, Vector2, Vector2, Ptr{Vector2}), startPos1, endPos1, startPos2, endPos2, collisionPoint)
end

function CheckCollisionPointLine(point, p1, p2, threshold)
    ccall((:CheckCollisionPointLine, raylib), Bool, (Vector2, Vector2, Vector2, Cint), point, p1, p2, threshold)
end

function GetCollisionRec(rec1, rec2)
    ccall((:GetCollisionRec, raylib), Rectangle, (Rectangle, Rectangle), rec1, rec2)
end

function LoadImage(fileName)
    ccall((:LoadImage, raylib), Image, (Ptr{Cchar},), fileName)
end

function LoadImageRaw(fileName, width, height, format, headerSize)
    ccall((:LoadImageRaw, raylib), Image, (Ptr{Cchar}, Cint, Cint, Cint, Cint), fileName, width, height, format, headerSize)
end

function LoadImageSvg(fileNameOrString, width, height)
    ccall((:LoadImageSvg, raylib), Image, (Ptr{Cchar}, Cint, Cint), fileNameOrString, width, height)
end

function LoadImageAnim(fileName, frames)
    ccall((:LoadImageAnim, raylib), Image, (Ptr{Cchar}, Ptr{Cint}), fileName, frames)
end

function LoadImageFromMemory(fileType, fileData, dataSize)
    ccall((:LoadImageFromMemory, raylib), Image, (Ptr{Cchar}, Ptr{Cuchar}, Cint), fileType, fileData, dataSize)
end

function LoadImageFromTexture(texture)
    ccall((:LoadImageFromTexture, raylib), Image, (Texture2D,), texture)
end

function LoadImageFromScreen()
    ccall((:LoadImageFromScreen, raylib), Image, ())
end

function IsImageReady(image)
    ccall((:IsImageReady, raylib), Bool, (Image,), image)
end

function UnloadImage(image)
    ccall((:UnloadImage, raylib), Cvoid, (Image,), image)
end

function ExportImage(image, fileName)
    ccall((:ExportImage, raylib), Bool, (Image, Ptr{Cchar}), image, fileName)
end

function ExportImageToMemory(image, fileType, fileSize)
    ccall((:ExportImageToMemory, raylib), Ptr{Cuchar}, (Image, Ptr{Cchar}, Ptr{Cint}), image, fileType, fileSize)
end

function ExportImageAsCode(image, fileName)
    ccall((:ExportImageAsCode, raylib), Bool, (Image, Ptr{Cchar}), image, fileName)
end

function GenImageColor(width, height, color)
    ccall((:GenImageColor, raylib), Image, (Cint, Cint, Color), width, height, color)
end

function GenImageGradientLinear(width, height, direction, start, _end)
    ccall((:GenImageGradientLinear, raylib), Image, (Cint, Cint, Cint, Color, Color), width, height, direction, start, _end)
end

function GenImageGradientRadial(width, height, density, inner, outer)
    ccall((:GenImageGradientRadial, raylib), Image, (Cint, Cint, Cfloat, Color, Color), width, height, density, inner, outer)
end

function GenImageGradientSquare(width, height, density, inner, outer)
    ccall((:GenImageGradientSquare, raylib), Image, (Cint, Cint, Cfloat, Color, Color), width, height, density, inner, outer)
end

function GenImageChecked(width, height, checksX, checksY, col1, col2)
    ccall((:GenImageChecked, raylib), Image, (Cint, Cint, Cint, Cint, Color, Color), width, height, checksX, checksY, col1, col2)
end

function GenImageWhiteNoise(width, height, factor)
    ccall((:GenImageWhiteNoise, raylib), Image, (Cint, Cint, Cfloat), width, height, factor)
end

function GenImagePerlinNoise(width, height, offsetX, offsetY, scale)
    ccall((:GenImagePerlinNoise, raylib), Image, (Cint, Cint, Cint, Cint, Cfloat), width, height, offsetX, offsetY, scale)
end

function GenImageCellular(width, height, tileSize)
    ccall((:GenImageCellular, raylib), Image, (Cint, Cint, Cint), width, height, tileSize)
end

function GenImageText(width, height, text)
    ccall((:GenImageText, raylib), Image, (Cint, Cint, Ptr{Cchar}), width, height, text)
end

function ImageCopy(image)
    ccall((:ImageCopy, raylib), Image, (Image,), image)
end

function ImageFromImage(image, rec)
    ccall((:ImageFromImage, raylib), Image, (Image, Rectangle), image, rec)
end

function ImageText(text, fontSize, color)
    ccall((:ImageText, raylib), Image, (Ptr{Cchar}, Cint, Color), text, fontSize, color)
end

function ImageTextEx(font, text, fontSize, spacing, tint)
    ccall((:ImageTextEx, raylib), Image, (Font, Ptr{Cchar}, Cfloat, Cfloat, Color), font, text, fontSize, spacing, tint)
end

function ImageFormat(image, newFormat)
    ccall((:ImageFormat, raylib), Cvoid, (Ptr{Image}, Cint), image, newFormat)
end

function ImageToPOT(image, fill)
    ccall((:ImageToPOT, raylib), Cvoid, (Ptr{Image}, Color), image, fill)
end

function ImageCrop(image, crop)
    ccall((:ImageCrop, raylib), Cvoid, (Ptr{Image}, Rectangle), image, crop)
end

function ImageAlphaCrop(image, threshold)
    ccall((:ImageAlphaCrop, raylib), Cvoid, (Ptr{Image}, Cfloat), image, threshold)
end

function ImageAlphaClear(image, color, threshold)
    ccall((:ImageAlphaClear, raylib), Cvoid, (Ptr{Image}, Color, Cfloat), image, color, threshold)
end

function ImageAlphaMask(image, alphaMask)
    ccall((:ImageAlphaMask, raylib), Cvoid, (Ptr{Image}, Image), image, alphaMask)
end

function ImageAlphaPremultiply(image)
    ccall((:ImageAlphaPremultiply, raylib), Cvoid, (Ptr{Image},), image)
end

function ImageBlurGaussian(image, blurSize)
    ccall((:ImageBlurGaussian, raylib), Cvoid, (Ptr{Image}, Cint), image, blurSize)
end

function ImageResize(image, newWidth, newHeight)
    ccall((:ImageResize, raylib), Cvoid, (Ptr{Image}, Cint, Cint), image, newWidth, newHeight)
end

function ImageResizeNN(image, newWidth, newHeight)
    ccall((:ImageResizeNN, raylib), Cvoid, (Ptr{Image}, Cint, Cint), image, newWidth, newHeight)
end

function ImageResizeCanvas(image, newWidth, newHeight, offsetX, offsetY, fill)
    ccall((:ImageResizeCanvas, raylib), Cvoid, (Ptr{Image}, Cint, Cint, Cint, Cint, Color), image, newWidth, newHeight, offsetX, offsetY, fill)
end

function ImageMipmaps(image)
    ccall((:ImageMipmaps, raylib), Cvoid, (Ptr{Image},), image)
end

function ImageDither(image, rBpp, gBpp, bBpp, aBpp)
    ccall((:ImageDither, raylib), Cvoid, (Ptr{Image}, Cint, Cint, Cint, Cint), image, rBpp, gBpp, bBpp, aBpp)
end

function ImageFlipVertical(image)
    ccall((:ImageFlipVertical, raylib), Cvoid, (Ptr{Image},), image)
end

function ImageFlipHorizontal(image)
    ccall((:ImageFlipHorizontal, raylib), Cvoid, (Ptr{Image},), image)
end

function ImageRotate(image, degrees)
    ccall((:ImageRotate, raylib), Cvoid, (Ptr{Image}, Cint), image, degrees)
end

function ImageRotateCW(image)
    ccall((:ImageRotateCW, raylib), Cvoid, (Ptr{Image},), image)
end

function ImageRotateCCW(image)
    ccall((:ImageRotateCCW, raylib), Cvoid, (Ptr{Image},), image)
end

function ImageColorTint(image, color)
    ccall((:ImageColorTint, raylib), Cvoid, (Ptr{Image}, Color), image, color)
end

function ImageColorInvert(image)
    ccall((:ImageColorInvert, raylib), Cvoid, (Ptr{Image},), image)
end

function ImageColorGrayscale(image)
    ccall((:ImageColorGrayscale, raylib), Cvoid, (Ptr{Image},), image)
end

function ImageColorContrast(image, contrast)
    ccall((:ImageColorContrast, raylib), Cvoid, (Ptr{Image}, Cfloat), image, contrast)
end

function ImageColorBrightness(image, brightness)
    ccall((:ImageColorBrightness, raylib), Cvoid, (Ptr{Image}, Cint), image, brightness)
end

function ImageColorReplace(image, color, replace)
    ccall((:ImageColorReplace, raylib), Cvoid, (Ptr{Image}, Color, Color), image, color, replace)
end

function LoadImageColors(image)
    ccall((:LoadImageColors, raylib), Ptr{Color}, (Image,), image)
end

function LoadImagePalette(image, maxPaletteSize, colorCount)
    ccall((:LoadImagePalette, raylib), Ptr{Color}, (Image, Cint, Ptr{Cint}), image, maxPaletteSize, colorCount)
end

function UnloadImageColors(colors)
    ccall((:UnloadImageColors, raylib), Cvoid, (Ptr{Color},), colors)
end

function UnloadImagePalette(colors)
    ccall((:UnloadImagePalette, raylib), Cvoid, (Ptr{Color},), colors)
end

function GetImageAlphaBorder(image, threshold)
    ccall((:GetImageAlphaBorder, raylib), Rectangle, (Image, Cfloat), image, threshold)
end

function GetImageColor(image, x, y)
    ccall((:GetImageColor, raylib), Color, (Image, Cint, Cint), image, x, y)
end

function ImageClearBackground(dst, color)
    ccall((:ImageClearBackground, raylib), Cvoid, (Ptr{Image}, Color), dst, color)
end

function ImageDrawPixel(dst, posX, posY, color)
    ccall((:ImageDrawPixel, raylib), Cvoid, (Ptr{Image}, Cint, Cint, Color), dst, posX, posY, color)
end

function ImageDrawPixelV(dst, position, color)
    ccall((:ImageDrawPixelV, raylib), Cvoid, (Ptr{Image}, Vector2, Color), dst, position, color)
end

function ImageDrawLine(dst, startPosX, startPosY, endPosX, endPosY, color)
    ccall((:ImageDrawLine, raylib), Cvoid, (Ptr{Image}, Cint, Cint, Cint, Cint, Color), dst, startPosX, startPosY, endPosX, endPosY, color)
end

function ImageDrawLineV(dst, start, _end, color)
    ccall((:ImageDrawLineV, raylib), Cvoid, (Ptr{Image}, Vector2, Vector2, Color), dst, start, _end, color)
end

function ImageDrawCircle(dst, centerX, centerY, radius, color)
    ccall((:ImageDrawCircle, raylib), Cvoid, (Ptr{Image}, Cint, Cint, Cint, Color), dst, centerX, centerY, radius, color)
end

function ImageDrawCircleV(dst, center, radius, color)
    ccall((:ImageDrawCircleV, raylib), Cvoid, (Ptr{Image}, Vector2, Cint, Color), dst, center, radius, color)
end

function ImageDrawCircleLines(dst, centerX, centerY, radius, color)
    ccall((:ImageDrawCircleLines, raylib), Cvoid, (Ptr{Image}, Cint, Cint, Cint, Color), dst, centerX, centerY, radius, color)
end

function ImageDrawCircleLinesV(dst, center, radius, color)
    ccall((:ImageDrawCircleLinesV, raylib), Cvoid, (Ptr{Image}, Vector2, Cint, Color), dst, center, radius, color)
end

function ImageDrawRectangle(dst, posX, posY, width, height, color)
    ccall((:ImageDrawRectangle, raylib), Cvoid, (Ptr{Image}, Cint, Cint, Cint, Cint, Color), dst, posX, posY, width, height, color)
end

function ImageDrawRectangleV(dst, position, size, color)
    ccall((:ImageDrawRectangleV, raylib), Cvoid, (Ptr{Image}, Vector2, Vector2, Color), dst, position, size, color)
end

function ImageDrawRectangleRec(dst, rec, color)
    ccall((:ImageDrawRectangleRec, raylib), Cvoid, (Ptr{Image}, Rectangle, Color), dst, rec, color)
end

function ImageDrawRectangleLines(dst, rec, thick, color)
    ccall((:ImageDrawRectangleLines, raylib), Cvoid, (Ptr{Image}, Rectangle, Cint, Color), dst, rec, thick, color)
end

function ImageDraw(dst, src, srcRec, dstRec, tint)
    ccall((:ImageDraw, raylib), Cvoid, (Ptr{Image}, Image, Rectangle, Rectangle, Color), dst, src, srcRec, dstRec, tint)
end

function ImageDrawText(dst, text, posX, posY, fontSize, color)
    ccall((:ImageDrawText, raylib), Cvoid, (Ptr{Image}, Ptr{Cchar}, Cint, Cint, Cint, Color), dst, text, posX, posY, fontSize, color)
end

function ImageDrawTextEx(dst, font, text, position, fontSize, spacing, tint)
    ccall((:ImageDrawTextEx, raylib), Cvoid, (Ptr{Image}, Font, Ptr{Cchar}, Vector2, Cfloat, Cfloat, Color), dst, font, text, position, fontSize, spacing, tint)
end

function LoadTexture(fileName)
    ccall((:LoadTexture, raylib), Texture2D, (Ptr{Cchar},), fileName)
end

function LoadTextureFromImage(image)
    ccall((:LoadTextureFromImage, raylib), Texture2D, (Image,), image)
end

function LoadTextureCubemap(image, layout)
    ccall((:LoadTextureCubemap, raylib), TextureCubemap, (Image, Cint), image, layout)
end

function LoadRenderTexture(width, height)
    ccall((:LoadRenderTexture, raylib), RenderTexture2D, (Cint, Cint), width, height)
end

function IsTextureReady(texture)
    ccall((:IsTextureReady, raylib), Bool, (Texture2D,), texture)
end

function UnloadTexture(texture)
    ccall((:UnloadTexture, raylib), Cvoid, (Texture2D,), texture)
end

function IsRenderTextureReady(target)
    ccall((:IsRenderTextureReady, raylib), Bool, (RenderTexture2D,), target)
end

function UnloadRenderTexture(target)
    ccall((:UnloadRenderTexture, raylib), Cvoid, (RenderTexture2D,), target)
end

function UpdateTexture(texture, pixels)
    ccall((:UpdateTexture, raylib), Cvoid, (Texture2D, Ptr{Cvoid}), texture, pixels)
end

function UpdateTextureRec(texture, rec, pixels)
    ccall((:UpdateTextureRec, raylib), Cvoid, (Texture2D, Rectangle, Ptr{Cvoid}), texture, rec, pixels)
end

function GenTextureMipmaps(texture)
    ccall((:GenTextureMipmaps, raylib), Cvoid, (Ptr{Texture2D},), texture)
end

function SetTextureFilter(texture, filter)
    ccall((:SetTextureFilter, raylib), Cvoid, (Texture2D, Cint), texture, filter)
end

function SetTextureWrap(texture, wrap)
    ccall((:SetTextureWrap, raylib), Cvoid, (Texture2D, Cint), texture, wrap)
end

function DrawTexture(texture, posX, posY, tint)
    ccall((:DrawTexture, raylib), Cvoid, (Texture2D, Cint, Cint, Color), texture, posX, posY, tint)
end

function DrawTextureV(texture, position, tint)
    ccall((:DrawTextureV, raylib), Cvoid, (Texture2D, Vector2, Color), texture, position, tint)
end

function DrawTextureEx(texture, position, rotation, scale, tint)
    ccall((:DrawTextureEx, raylib), Cvoid, (Texture2D, Vector2, Cfloat, Cfloat, Color), texture, position, rotation, scale, tint)
end

function DrawTextureRec(texture, source, position, tint)
    ccall((:DrawTextureRec, raylib), Cvoid, (Texture2D, Rectangle, Vector2, Color), texture, source, position, tint)
end

function DrawTexturePro(texture, source, dest, origin, rotation, tint)
    ccall((:DrawTexturePro, raylib), Cvoid, (Texture2D, Rectangle, Rectangle, Vector2, Cfloat, Color), texture, source, dest, origin, rotation, tint)
end

function DrawTextureNPatch(texture, nPatchInfo, dest, origin, rotation, tint)
    ccall((:DrawTextureNPatch, raylib), Cvoid, (Texture2D, NPatchInfo, Rectangle, Vector2, Cfloat, Color), texture, nPatchInfo, dest, origin, rotation, tint)
end

function Fade(color, alpha)
    ccall((:Fade, raylib), Color, (Color, Cfloat), color, alpha)
end

function ColorToInt(color)
    ccall((:ColorToInt, raylib), Cint, (Color,), color)
end

function ColorNormalize(color)
    ccall((:ColorNormalize, raylib), Vector4, (Color,), color)
end

function ColorFromNormalized(normalized)
    ccall((:ColorFromNormalized, raylib), Color, (Vector4,), normalized)
end

function ColorToHSV(color)
    ccall((:ColorToHSV, raylib), Vector3, (Color,), color)
end

function ColorFromHSV(hue, saturation, value)
    ccall((:ColorFromHSV, raylib), Color, (Cfloat, Cfloat, Cfloat), hue, saturation, value)
end

function ColorTint(color, tint)
    ccall((:ColorTint, raylib), Color, (Color, Color), color, tint)
end

function ColorBrightness(color, factor)
    ccall((:ColorBrightness, raylib), Color, (Color, Cfloat), color, factor)
end

function ColorContrast(color, contrast)
    ccall((:ColorContrast, raylib), Color, (Color, Cfloat), color, contrast)
end

function ColorAlpha(color, alpha)
    ccall((:ColorAlpha, raylib), Color, (Color, Cfloat), color, alpha)
end

function ColorAlphaBlend(dst, src, tint)
    ccall((:ColorAlphaBlend, raylib), Color, (Color, Color, Color), dst, src, tint)
end

function GetColor(hexValue)
    ccall((:GetColor, raylib), Color, (Cuint,), hexValue)
end

function GetPixelColor(srcPtr, format)
    ccall((:GetPixelColor, raylib), Color, (Ptr{Cvoid}, Cint), srcPtr, format)
end

function SetPixelColor(dstPtr, color, format)
    ccall((:SetPixelColor, raylib), Cvoid, (Ptr{Cvoid}, Color, Cint), dstPtr, color, format)
end

function GetPixelDataSize(width, height, format)
    ccall((:GetPixelDataSize, raylib), Cint, (Cint, Cint, Cint), width, height, format)
end

function GetFontDefault()
    ccall((:GetFontDefault, raylib), Font, ())
end

function LoadFont(fileName)
    ccall((:LoadFont, raylib), Font, (Ptr{Cchar},), fileName)
end

function LoadFontEx(fileName, fontSize, codepoints, codepointCount)
    ccall((:LoadFontEx, raylib), Font, (Ptr{Cchar}, Cint, Ptr{Cint}, Cint), fileName, fontSize, codepoints, codepointCount)
end

function LoadFontFromImage(image, key, firstChar)
    ccall((:LoadFontFromImage, raylib), Font, (Image, Color, Cint), image, key, firstChar)
end

function LoadFontFromMemory(fileType, fileData, dataSize, fontSize, codepoints, codepointCount)
    ccall((:LoadFontFromMemory, raylib), Font, (Ptr{Cchar}, Ptr{Cuchar}, Cint, Cint, Ptr{Cint}, Cint), fileType, fileData, dataSize, fontSize, codepoints, codepointCount)
end

function IsFontReady(font)
    ccall((:IsFontReady, raylib), Bool, (Font,), font)
end

function LoadFontData(fileData, dataSize, fontSize, codepoints, codepointCount, type)
    ccall((:LoadFontData, raylib), Ptr{GlyphInfo}, (Ptr{Cuchar}, Cint, Cint, Ptr{Cint}, Cint, Cint), fileData, dataSize, fontSize, codepoints, codepointCount, type)
end

function GenImageFontAtlas(glyphs, glyphRecs, glyphCount, fontSize, padding, packMethod)
    ccall((:GenImageFontAtlas, raylib), Image, (Ptr{GlyphInfo}, Ptr{Ptr{Rectangle}}, Cint, Cint, Cint, Cint), glyphs, glyphRecs, glyphCount, fontSize, padding, packMethod)
end

function UnloadFontData(glyphs, glyphCount)
    ccall((:UnloadFontData, raylib), Cvoid, (Ptr{GlyphInfo}, Cint), glyphs, glyphCount)
end

function UnloadFont(font)
    ccall((:UnloadFont, raylib), Cvoid, (Font,), font)
end

function ExportFontAsCode(font, fileName)
    ccall((:ExportFontAsCode, raylib), Bool, (Font, Ptr{Cchar}), font, fileName)
end

function DrawFPS(posX, posY)
    ccall((:DrawFPS, raylib), Cvoid, (Cint, Cint), posX, posY)
end

function DrawText(text, posX, posY, fontSize, color)
    ccall((:DrawText, raylib), Cvoid, (Ptr{Cchar}, Cint, Cint, Cint, Color), text, posX, posY, fontSize, color)
end

function DrawTextEx(font, text, position, fontSize, spacing, tint)
    ccall((:DrawTextEx, raylib), Cvoid, (Font, Ptr{Cchar}, Vector2, Cfloat, Cfloat, Color), font, text, position, fontSize, spacing, tint)
end

function DrawTextPro(font, text, position, origin, rotation, fontSize, spacing, tint)
    ccall((:DrawTextPro, raylib), Cvoid, (Font, Ptr{Cchar}, Vector2, Vector2, Cfloat, Cfloat, Cfloat, Color), font, text, position, origin, rotation, fontSize, spacing, tint)
end

function DrawTextCodepoint(font, codepoint, position, fontSize, tint)
    ccall((:DrawTextCodepoint, raylib), Cvoid, (Font, Cint, Vector2, Cfloat, Color), font, codepoint, position, fontSize, tint)
end

function DrawTextCodepoints(font, codepoints, codepointCount, position, fontSize, spacing, tint)
    ccall((:DrawTextCodepoints, raylib), Cvoid, (Font, Ptr{Cint}, Cint, Vector2, Cfloat, Cfloat, Color), font, codepoints, codepointCount, position, fontSize, spacing, tint)
end

function SetTextLineSpacing(spacing)
    ccall((:SetTextLineSpacing, raylib), Cvoid, (Cint,), spacing)
end

function MeasureText(text, fontSize)
    ccall((:MeasureText, raylib), Cint, (Ptr{Cchar}, Cint), text, fontSize)
end

function MeasureTextEx(font, text, fontSize, spacing)
    ccall((:MeasureTextEx, raylib), Vector2, (Font, Ptr{Cchar}, Cfloat, Cfloat), font, text, fontSize, spacing)
end

function GetGlyphIndex(font, codepoint)
    ccall((:GetGlyphIndex, raylib), Cint, (Font, Cint), font, codepoint)
end

function GetGlyphInfo(font, codepoint)
    ccall((:GetGlyphInfo, raylib), GlyphInfo, (Font, Cint), font, codepoint)
end

function GetGlyphAtlasRec(font, codepoint)
    ccall((:GetGlyphAtlasRec, raylib), Rectangle, (Font, Cint), font, codepoint)
end

function LoadUTF8(codepoints, length)
    ccall((:LoadUTF8, raylib), Ptr{Cchar}, (Ptr{Cint}, Cint), codepoints, length)
end

function UnloadUTF8(text)
    ccall((:UnloadUTF8, raylib), Cvoid, (Ptr{Cchar},), text)
end

function LoadCodepoints(text, count)
    ccall((:LoadCodepoints, raylib), Ptr{Cint}, (Ptr{Cchar}, Ptr{Cint}), text, count)
end

function UnloadCodepoints(codepoints)
    ccall((:UnloadCodepoints, raylib), Cvoid, (Ptr{Cint},), codepoints)
end

function GetCodepointCount(text)
    ccall((:GetCodepointCount, raylib), Cint, (Ptr{Cchar},), text)
end

function GetCodepoint(text, codepointSize)
    ccall((:GetCodepoint, raylib), Cint, (Ptr{Cchar}, Ptr{Cint}), text, codepointSize)
end

function GetCodepointNext(text, codepointSize)
    ccall((:GetCodepointNext, raylib), Cint, (Ptr{Cchar}, Ptr{Cint}), text, codepointSize)
end

function GetCodepointPrevious(text, codepointSize)
    ccall((:GetCodepointPrevious, raylib), Cint, (Ptr{Cchar}, Ptr{Cint}), text, codepointSize)
end

function CodepointToUTF8(codepoint, utf8Size)
    ccall((:CodepointToUTF8, raylib), Ptr{Cchar}, (Cint, Ptr{Cint}), codepoint, utf8Size)
end

function TextCopy(dst, src)
    ccall((:TextCopy, raylib), Cint, (Ptr{Cchar}, Ptr{Cchar}), dst, src)
end

function TextIsEqual(text1, text2)
    ccall((:TextIsEqual, raylib), Bool, (Ptr{Cchar}, Ptr{Cchar}), text1, text2)
end

function TextLength(text)
    ccall((:TextLength, raylib), Cuint, (Ptr{Cchar},), text)
end

function TextSubtext(text, position, length)
    ccall((:TextSubtext, raylib), Ptr{Cchar}, (Ptr{Cchar}, Cint, Cint), text, position, length)
end

function TextReplace(text, replace, by)
    ccall((:TextReplace, raylib), Ptr{Cchar}, (Ptr{Cchar}, Ptr{Cchar}, Ptr{Cchar}), text, replace, by)
end

function TextInsert(text, insert, position)
    ccall((:TextInsert, raylib), Ptr{Cchar}, (Ptr{Cchar}, Ptr{Cchar}, Cint), text, insert, position)
end

function TextJoin(textList, count, delimiter)
    ccall((:TextJoin, raylib), Ptr{Cchar}, (Ptr{Ptr{Cchar}}, Cint, Ptr{Cchar}), textList, count, delimiter)
end

function TextSplit(text, delimiter, count)
    ccall((:TextSplit, raylib), Ptr{Ptr{Cchar}}, (Ptr{Cchar}, Cchar, Ptr{Cint}), text, delimiter, count)
end

function TextAppend(text, append, position)
    ccall((:TextAppend, raylib), Cvoid, (Ptr{Cchar}, Ptr{Cchar}, Ptr{Cint}), text, append, position)
end

function TextFindIndex(text, find)
    ccall((:TextFindIndex, raylib), Cint, (Ptr{Cchar}, Ptr{Cchar}), text, find)
end

function TextToUpper(text)
    ccall((:TextToUpper, raylib), Ptr{Cchar}, (Ptr{Cchar},), text)
end

function TextToLower(text)
    ccall((:TextToLower, raylib), Ptr{Cchar}, (Ptr{Cchar},), text)
end

function TextToPascal(text)
    ccall((:TextToPascal, raylib), Ptr{Cchar}, (Ptr{Cchar},), text)
end

function TextToInteger(text)
    ccall((:TextToInteger, raylib), Cint, (Ptr{Cchar},), text)
end

function DrawLine3D(startPos, endPos, color)
    ccall((:DrawLine3D, raylib), Cvoid, (Vector3, Vector3, Color), startPos, endPos, color)
end

function DrawPoint3D(position, color)
    ccall((:DrawPoint3D, raylib), Cvoid, (Vector3, Color), position, color)
end

function DrawCircle3D(center, radius, rotationAxis, rotationAngle, color)
    ccall((:DrawCircle3D, raylib), Cvoid, (Vector3, Cfloat, Vector3, Cfloat, Color), center, radius, rotationAxis, rotationAngle, color)
end

function DrawTriangle3D(v1, v2, v3, color)
    ccall((:DrawTriangle3D, raylib), Cvoid, (Vector3, Vector3, Vector3, Color), v1, v2, v3, color)
end

function DrawTriangleStrip3D(points, pointCount, color)
    ccall((:DrawTriangleStrip3D, raylib), Cvoid, (Ptr{Vector3}, Cint, Color), points, pointCount, color)
end

function DrawCube(position, width, height, length, color)
    ccall((:DrawCube, raylib), Cvoid, (Vector3, Cfloat, Cfloat, Cfloat, Color), position, width, height, length, color)
end

function DrawCubeV(position, size, color)
    ccall((:DrawCubeV, raylib), Cvoid, (Vector3, Vector3, Color), position, size, color)
end

function DrawCubeWires(position, width, height, length, color)
    ccall((:DrawCubeWires, raylib), Cvoid, (Vector3, Cfloat, Cfloat, Cfloat, Color), position, width, height, length, color)
end

function DrawCubeWiresV(position, size, color)
    ccall((:DrawCubeWiresV, raylib), Cvoid, (Vector3, Vector3, Color), position, size, color)
end

function DrawSphere(centerPos, radius, color)
    ccall((:DrawSphere, raylib), Cvoid, (Vector3, Cfloat, Color), centerPos, radius, color)
end

function DrawSphereEx(centerPos, radius, rings, slices, color)
    ccall((:DrawSphereEx, raylib), Cvoid, (Vector3, Cfloat, Cint, Cint, Color), centerPos, radius, rings, slices, color)
end

function DrawSphereWires(centerPos, radius, rings, slices, color)
    ccall((:DrawSphereWires, raylib), Cvoid, (Vector3, Cfloat, Cint, Cint, Color), centerPos, radius, rings, slices, color)
end

function DrawCylinder(position, radiusTop, radiusBottom, height, slices, color)
    ccall((:DrawCylinder, raylib), Cvoid, (Vector3, Cfloat, Cfloat, Cfloat, Cint, Color), position, radiusTop, radiusBottom, height, slices, color)
end

function DrawCylinderEx(startPos, endPos, startRadius, endRadius, sides, color)
    ccall((:DrawCylinderEx, raylib), Cvoid, (Vector3, Vector3, Cfloat, Cfloat, Cint, Color), startPos, endPos, startRadius, endRadius, sides, color)
end

function DrawCylinderWires(position, radiusTop, radiusBottom, height, slices, color)
    ccall((:DrawCylinderWires, raylib), Cvoid, (Vector3, Cfloat, Cfloat, Cfloat, Cint, Color), position, radiusTop, radiusBottom, height, slices, color)
end

function DrawCylinderWiresEx(startPos, endPos, startRadius, endRadius, sides, color)
    ccall((:DrawCylinderWiresEx, raylib), Cvoid, (Vector3, Vector3, Cfloat, Cfloat, Cint, Color), startPos, endPos, startRadius, endRadius, sides, color)
end

function DrawCapsule(startPos, endPos, radius, slices, rings, color)
    ccall((:DrawCapsule, raylib), Cvoid, (Vector3, Vector3, Cfloat, Cint, Cint, Color), startPos, endPos, radius, slices, rings, color)
end

function DrawCapsuleWires(startPos, endPos, radius, slices, rings, color)
    ccall((:DrawCapsuleWires, raylib), Cvoid, (Vector3, Vector3, Cfloat, Cint, Cint, Color), startPos, endPos, radius, slices, rings, color)
end

function DrawPlane(centerPos, size, color)
    ccall((:DrawPlane, raylib), Cvoid, (Vector3, Vector2, Color), centerPos, size, color)
end

function DrawRay(ray, color)
    ccall((:DrawRay, raylib), Cvoid, (Ray, Color), ray, color)
end

function DrawGrid(slices, spacing)
    ccall((:DrawGrid, raylib), Cvoid, (Cint, Cfloat), slices, spacing)
end

function LoadModel(fileName)
    ccall((:LoadModel, raylib), Model, (Ptr{Cchar},), fileName)
end

function LoadModelFromMesh(mesh)
    ccall((:LoadModelFromMesh, raylib), Model, (Mesh,), mesh)
end

function IsModelReady(model)
    ccall((:IsModelReady, raylib), Bool, (Model,), model)
end

function UnloadModel(model)
    ccall((:UnloadModel, raylib), Cvoid, (Model,), model)
end

function GetModelBoundingBox(model)
    ccall((:GetModelBoundingBox, raylib), BoundingBox, (Model,), model)
end

function DrawModel(model, position, scale, tint)
    ccall((:DrawModel, raylib), Cvoid, (Model, Vector3, Cfloat, Color), model, position, scale, tint)
end

function DrawModelEx(model, position, rotationAxis, rotationAngle, scale, tint)
    ccall((:DrawModelEx, raylib), Cvoid, (Model, Vector3, Vector3, Cfloat, Vector3, Color), model, position, rotationAxis, rotationAngle, scale, tint)
end

function DrawModelWires(model, position, scale, tint)
    ccall((:DrawModelWires, raylib), Cvoid, (Model, Vector3, Cfloat, Color), model, position, scale, tint)
end

function DrawModelWiresEx(model, position, rotationAxis, rotationAngle, scale, tint)
    ccall((:DrawModelWiresEx, raylib), Cvoid, (Model, Vector3, Vector3, Cfloat, Vector3, Color), model, position, rotationAxis, rotationAngle, scale, tint)
end

function DrawBoundingBox(box, color)
    ccall((:DrawBoundingBox, raylib), Cvoid, (BoundingBox, Color), box, color)
end

function DrawBillboard(camera, texture, position, size, tint)
    ccall((:DrawBillboard, raylib), Cvoid, (Camera, Texture2D, Vector3, Cfloat, Color), camera, texture, position, size, tint)
end

function DrawBillboardRec(camera, texture, source, position, size, tint)
    ccall((:DrawBillboardRec, raylib), Cvoid, (Camera, Texture2D, Rectangle, Vector3, Vector2, Color), camera, texture, source, position, size, tint)
end

function DrawBillboardPro(camera, texture, source, position, up, size, origin, rotation, tint)
    ccall((:DrawBillboardPro, raylib), Cvoid, (Camera, Texture2D, Rectangle, Vector3, Vector3, Vector2, Vector2, Cfloat, Color), camera, texture, source, position, up, size, origin, rotation, tint)
end

function UploadMesh(mesh, dynamic)
    ccall((:UploadMesh, raylib), Cvoid, (Ptr{Mesh}, Bool), mesh, dynamic)
end

function UpdateMeshBuffer(mesh, index, data, dataSize, offset)
    ccall((:UpdateMeshBuffer, raylib), Cvoid, (Mesh, Cint, Ptr{Cvoid}, Cint, Cint), mesh, index, data, dataSize, offset)
end

function UnloadMesh(mesh)
    ccall((:UnloadMesh, raylib), Cvoid, (Mesh,), mesh)
end

function DrawMesh(mesh, material, transform)
    ccall((:DrawMesh, raylib), Cvoid, (Mesh, Material, Matrix), mesh, material, transform)
end

function DrawMeshInstanced(mesh, material, transforms, instances)
    ccall((:DrawMeshInstanced, raylib), Cvoid, (Mesh, Material, Ptr{Matrix}, Cint), mesh, material, transforms, instances)
end

function ExportMesh(mesh, fileName)
    ccall((:ExportMesh, raylib), Bool, (Mesh, Ptr{Cchar}), mesh, fileName)
end

function GetMeshBoundingBox(mesh)
    ccall((:GetMeshBoundingBox, raylib), BoundingBox, (Mesh,), mesh)
end

function GenMeshTangents(mesh)
    ccall((:GenMeshTangents, raylib), Cvoid, (Ptr{Mesh},), mesh)
end

function GenMeshPoly(sides, radius)
    ccall((:GenMeshPoly, raylib), Mesh, (Cint, Cfloat), sides, radius)
end

function GenMeshPlane(width, length, resX, resZ)
    ccall((:GenMeshPlane, raylib), Mesh, (Cfloat, Cfloat, Cint, Cint), width, length, resX, resZ)
end

function GenMeshCube(width, height, length)
    ccall((:GenMeshCube, raylib), Mesh, (Cfloat, Cfloat, Cfloat), width, height, length)
end

function GenMeshSphere(radius, rings, slices)
    ccall((:GenMeshSphere, raylib), Mesh, (Cfloat, Cint, Cint), radius, rings, slices)
end

function GenMeshHemiSphere(radius, rings, slices)
    ccall((:GenMeshHemiSphere, raylib), Mesh, (Cfloat, Cint, Cint), radius, rings, slices)
end

function GenMeshCylinder(radius, height, slices)
    ccall((:GenMeshCylinder, raylib), Mesh, (Cfloat, Cfloat, Cint), radius, height, slices)
end

function GenMeshCone(radius, height, slices)
    ccall((:GenMeshCone, raylib), Mesh, (Cfloat, Cfloat, Cint), radius, height, slices)
end

function GenMeshTorus(radius, size, radSeg, sides)
    ccall((:GenMeshTorus, raylib), Mesh, (Cfloat, Cfloat, Cint, Cint), radius, size, radSeg, sides)
end

function GenMeshKnot(radius, size, radSeg, sides)
    ccall((:GenMeshKnot, raylib), Mesh, (Cfloat, Cfloat, Cint, Cint), radius, size, radSeg, sides)
end

function GenMeshHeightmap(heightmap, size)
    ccall((:GenMeshHeightmap, raylib), Mesh, (Image, Vector3), heightmap, size)
end

function GenMeshCubicmap(cubicmap, cubeSize)
    ccall((:GenMeshCubicmap, raylib), Mesh, (Image, Vector3), cubicmap, cubeSize)
end

function LoadMaterials(fileName, materialCount)
    ccall((:LoadMaterials, raylib), Ptr{Material}, (Ptr{Cchar}, Ptr{Cint}), fileName, materialCount)
end

function LoadMaterialDefault()
    ccall((:LoadMaterialDefault, raylib), Material, ())
end

function IsMaterialReady(material)
    ccall((:IsMaterialReady, raylib), Bool, (Material,), material)
end

function UnloadMaterial(material)
    ccall((:UnloadMaterial, raylib), Cvoid, (Material,), material)
end

function SetMaterialTexture(material, mapType, texture)
    ccall((:SetMaterialTexture, raylib), Cvoid, (Ptr{Material}, Cint, Texture2D), material, mapType, texture)
end

function SetModelMeshMaterial(model, meshId, materialId)
    ccall((:SetModelMeshMaterial, raylib), Cvoid, (Ptr{Model}, Cint, Cint), model, meshId, materialId)
end

function LoadModelAnimations(fileName, animCount)
    ccall((:LoadModelAnimations, raylib), Ptr{ModelAnimation}, (Ptr{Cchar}, Ptr{Cint}), fileName, animCount)
end

function UpdateModelAnimation(model, anim, frame)
    ccall((:UpdateModelAnimation, raylib), Cvoid, (Model, ModelAnimation, Cint), model, anim, frame)
end

function UnloadModelAnimation(anim)
    ccall((:UnloadModelAnimation, raylib), Cvoid, (ModelAnimation,), anim)
end

function UnloadModelAnimations(animations, animCount)
    ccall((:UnloadModelAnimations, raylib), Cvoid, (Ptr{ModelAnimation}, Cint), animations, animCount)
end

function IsModelAnimationValid(model, anim)
    ccall((:IsModelAnimationValid, raylib), Bool, (Model, ModelAnimation), model, anim)
end

function CheckCollisionSpheres(center1, radius1, center2, radius2)
    ccall((:CheckCollisionSpheres, raylib), Bool, (Vector3, Cfloat, Vector3, Cfloat), center1, radius1, center2, radius2)
end

function CheckCollisionBoxes(box1, box2)
    ccall((:CheckCollisionBoxes, raylib), Bool, (BoundingBox, BoundingBox), box1, box2)
end

function CheckCollisionBoxSphere(box, center, radius)
    ccall((:CheckCollisionBoxSphere, raylib), Bool, (BoundingBox, Vector3, Cfloat), box, center, radius)
end

function GetRayCollisionSphere(ray, center, radius)
    ccall((:GetRayCollisionSphere, raylib), RayCollision, (Ray, Vector3, Cfloat), ray, center, radius)
end

function GetRayCollisionBox(ray, box)
    ccall((:GetRayCollisionBox, raylib), RayCollision, (Ray, BoundingBox), ray, box)
end

function GetRayCollisionMesh(ray, mesh, transform)
    ccall((:GetRayCollisionMesh, raylib), RayCollision, (Ray, Mesh, Matrix), ray, mesh, transform)
end

function GetRayCollisionTriangle(ray, p1, p2, p3)
    ccall((:GetRayCollisionTriangle, raylib), RayCollision, (Ray, Vector3, Vector3, Vector3), ray, p1, p2, p3)
end

function GetRayCollisionQuad(ray, p1, p2, p3, p4)
    ccall((:GetRayCollisionQuad, raylib), RayCollision, (Ray, Vector3, Vector3, Vector3, Vector3), ray, p1, p2, p3, p4)
end

# typedef void ( * AudioCallback ) ( void * bufferData , unsigned int frames )
const AudioCallback = Ptr{Cvoid}

function InitAudioDevice()
    ccall((:InitAudioDevice, raylib), Cvoid, ())
end

function CloseAudioDevice()
    ccall((:CloseAudioDevice, raylib), Cvoid, ())
end

function IsAudioDeviceReady()
    ccall((:IsAudioDeviceReady, raylib), Bool, ())
end

function SetMasterVolume(volume)
    ccall((:SetMasterVolume, raylib), Cvoid, (Cfloat,), volume)
end

function GetMasterVolume()
    ccall((:GetMasterVolume, raylib), Cfloat, ())
end

function LoadWave(fileName)
    ccall((:LoadWave, raylib), Wave, (Ptr{Cchar},), fileName)
end

function LoadWaveFromMemory(fileType, fileData, dataSize)
    ccall((:LoadWaveFromMemory, raylib), Wave, (Ptr{Cchar}, Ptr{Cuchar}, Cint), fileType, fileData, dataSize)
end

function IsWaveReady(wave)
    ccall((:IsWaveReady, raylib), Bool, (Wave,), wave)
end

function LoadSound(fileName)
    ccall((:LoadSound, raylib), Sound, (Ptr{Cchar},), fileName)
end

function LoadSoundFromWave(wave)
    ccall((:LoadSoundFromWave, raylib), Sound, (Wave,), wave)
end

function LoadSoundAlias(source)
    ccall((:LoadSoundAlias, raylib), Sound, (Sound,), source)
end

function IsSoundReady(sound)
    ccall((:IsSoundReady, raylib), Bool, (Sound,), sound)
end

function UpdateSound(sound, data, sampleCount)
    ccall((:UpdateSound, raylib), Cvoid, (Sound, Ptr{Cvoid}, Cint), sound, data, sampleCount)
end

function UnloadWave(wave)
    ccall((:UnloadWave, raylib), Cvoid, (Wave,), wave)
end

function UnloadSound(sound)
    ccall((:UnloadSound, raylib), Cvoid, (Sound,), sound)
end

function UnloadSoundAlias(alias)
    ccall((:UnloadSoundAlias, raylib), Cvoid, (Sound,), alias)
end

function ExportWave(wave, fileName)
    ccall((:ExportWave, raylib), Bool, (Wave, Ptr{Cchar}), wave, fileName)
end

function ExportWaveAsCode(wave, fileName)
    ccall((:ExportWaveAsCode, raylib), Bool, (Wave, Ptr{Cchar}), wave, fileName)
end

function PlaySound(sound)
    ccall((:PlaySound, raylib), Cvoid, (Sound,), sound)
end

function StopSound(sound)
    ccall((:StopSound, raylib), Cvoid, (Sound,), sound)
end

function PauseSound(sound)
    ccall((:PauseSound, raylib), Cvoid, (Sound,), sound)
end

function ResumeSound(sound)
    ccall((:ResumeSound, raylib), Cvoid, (Sound,), sound)
end

function IsSoundPlaying(sound)
    ccall((:IsSoundPlaying, raylib), Bool, (Sound,), sound)
end

function SetSoundVolume(sound, volume)
    ccall((:SetSoundVolume, raylib), Cvoid, (Sound, Cfloat), sound, volume)
end

function SetSoundPitch(sound, pitch)
    ccall((:SetSoundPitch, raylib), Cvoid, (Sound, Cfloat), sound, pitch)
end

function SetSoundPan(sound, pan)
    ccall((:SetSoundPan, raylib), Cvoid, (Sound, Cfloat), sound, pan)
end

function WaveCopy(wave)
    ccall((:WaveCopy, raylib), Wave, (Wave,), wave)
end

function WaveCrop(wave, initSample, finalSample)
    ccall((:WaveCrop, raylib), Cvoid, (Ptr{Wave}, Cint, Cint), wave, initSample, finalSample)
end

function WaveFormat(wave, sampleRate, sampleSize, channels)
    ccall((:WaveFormat, raylib), Cvoid, (Ptr{Wave}, Cint, Cint, Cint), wave, sampleRate, sampleSize, channels)
end

function LoadWaveSamples(wave)
    ccall((:LoadWaveSamples, raylib), Ptr{Cfloat}, (Wave,), wave)
end

function UnloadWaveSamples(samples)
    ccall((:UnloadWaveSamples, raylib), Cvoid, (Ptr{Cfloat},), samples)
end

function LoadMusicStream(fileName)
    ccall((:LoadMusicStream, raylib), Music, (Ptr{Cchar},), fileName)
end

function LoadMusicStreamFromMemory(fileType, data, dataSize)
    ccall((:LoadMusicStreamFromMemory, raylib), Music, (Ptr{Cchar}, Ptr{Cuchar}, Cint), fileType, data, dataSize)
end

function IsMusicReady(music)
    ccall((:IsMusicReady, raylib), Bool, (Music,), music)
end

function UnloadMusicStream(music)
    ccall((:UnloadMusicStream, raylib), Cvoid, (Music,), music)
end

function PlayMusicStream(music)
    ccall((:PlayMusicStream, raylib), Cvoid, (Music,), music)
end

function IsMusicStreamPlaying(music)
    ccall((:IsMusicStreamPlaying, raylib), Bool, (Music,), music)
end

function UpdateMusicStream(music)
    ccall((:UpdateMusicStream, raylib), Cvoid, (Music,), music)
end

function StopMusicStream(music)
    ccall((:StopMusicStream, raylib), Cvoid, (Music,), music)
end

function PauseMusicStream(music)
    ccall((:PauseMusicStream, raylib), Cvoid, (Music,), music)
end

function ResumeMusicStream(music)
    ccall((:ResumeMusicStream, raylib), Cvoid, (Music,), music)
end

function SeekMusicStream(music, position)
    ccall((:SeekMusicStream, raylib), Cvoid, (Music, Cfloat), music, position)
end

function SetMusicVolume(music, volume)
    ccall((:SetMusicVolume, raylib), Cvoid, (Music, Cfloat), music, volume)
end

function SetMusicPitch(music, pitch)
    ccall((:SetMusicPitch, raylib), Cvoid, (Music, Cfloat), music, pitch)
end

function SetMusicPan(music, pan)
    ccall((:SetMusicPan, raylib), Cvoid, (Music, Cfloat), music, pan)
end

function GetMusicTimeLength(music)
    ccall((:GetMusicTimeLength, raylib), Cfloat, (Music,), music)
end

function GetMusicTimePlayed(music)
    ccall((:GetMusicTimePlayed, raylib), Cfloat, (Music,), music)
end

function LoadAudioStream(sampleRate, sampleSize, channels)
    ccall((:LoadAudioStream, raylib), AudioStream, (Cuint, Cuint, Cuint), sampleRate, sampleSize, channels)
end

function IsAudioStreamReady(stream)
    ccall((:IsAudioStreamReady, raylib), Bool, (AudioStream,), stream)
end

function UnloadAudioStream(stream)
    ccall((:UnloadAudioStream, raylib), Cvoid, (AudioStream,), stream)
end

function UpdateAudioStream(stream, data, frameCount)
    ccall((:UpdateAudioStream, raylib), Cvoid, (AudioStream, Ptr{Cvoid}, Cint), stream, data, frameCount)
end

function IsAudioStreamProcessed(stream)
    ccall((:IsAudioStreamProcessed, raylib), Bool, (AudioStream,), stream)
end

function PlayAudioStream(stream)
    ccall((:PlayAudioStream, raylib), Cvoid, (AudioStream,), stream)
end

function PauseAudioStream(stream)
    ccall((:PauseAudioStream, raylib), Cvoid, (AudioStream,), stream)
end

function ResumeAudioStream(stream)
    ccall((:ResumeAudioStream, raylib), Cvoid, (AudioStream,), stream)
end

function IsAudioStreamPlaying(stream)
    ccall((:IsAudioStreamPlaying, raylib), Bool, (AudioStream,), stream)
end

function StopAudioStream(stream)
    ccall((:StopAudioStream, raylib), Cvoid, (AudioStream,), stream)
end

function SetAudioStreamVolume(stream, volume)
    ccall((:SetAudioStreamVolume, raylib), Cvoid, (AudioStream, Cfloat), stream, volume)
end

function SetAudioStreamPitch(stream, pitch)
    ccall((:SetAudioStreamPitch, raylib), Cvoid, (AudioStream, Cfloat), stream, pitch)
end

function SetAudioStreamPan(stream, pan)
    ccall((:SetAudioStreamPan, raylib), Cvoid, (AudioStream, Cfloat), stream, pan)
end

function SetAudioStreamBufferSizeDefault(size)
    ccall((:SetAudioStreamBufferSizeDefault, raylib), Cvoid, (Cint,), size)
end

function SetAudioStreamCallback(stream, callback)
    ccall((:SetAudioStreamCallback, raylib), Cvoid, (AudioStream, AudioCallback), stream, callback)
end

function AttachAudioStreamProcessor(stream, processor)
    ccall((:AttachAudioStreamProcessor, raylib), Cvoid, (AudioStream, AudioCallback), stream, processor)
end

function DetachAudioStreamProcessor(stream, processor)
    ccall((:DetachAudioStreamProcessor, raylib), Cvoid, (AudioStream, AudioCallback), stream, processor)
end

function AttachAudioMixedProcessor(processor)
    ccall((:AttachAudioMixedProcessor, raylib), Cvoid, (AudioCallback,), processor)
end

function DetachAudioMixedProcessor(processor)
    ccall((:DetachAudioMixedProcessor, raylib), Cvoid, (AudioCallback,), processor)
end

struct float16
    v::NTuple{16, Cfloat}
end

function MatrixToFloatV(mat)
    ccall((:MatrixToFloatV, raylib), float16, (Matrix,), mat)
end

struct float3
    v::NTuple{3, Cfloat}
end

function Vector3ToFloatV(v)
    ccall((:Vector3ToFloatV, raylib), float3, (Vector3,), v)
end

function Clamp(value, min, max)
    ccall((:Clamp, raylib), Cfloat, (Cfloat, Cfloat, Cfloat), value, min, max)
end

function Lerp(start, _end, amount)
    ccall((:Lerp, raylib), Cfloat, (Cfloat, Cfloat, Cfloat), start, _end, amount)
end

function Normalize(value, start, _end)
    ccall((:Normalize, raylib), Cfloat, (Cfloat, Cfloat, Cfloat), value, start, _end)
end

function Remap(value, inputStart, inputEnd, outputStart, outputEnd)
    ccall((:Remap, raylib), Cfloat, (Cfloat, Cfloat, Cfloat, Cfloat, Cfloat), value, inputStart, inputEnd, outputStart, outputEnd)
end

function Wrap(value, min, max)
    ccall((:Wrap, raylib), Cfloat, (Cfloat, Cfloat, Cfloat), value, min, max)
end

function FloatEquals(x, y)
    ccall((:FloatEquals, raylib), Cint, (Cfloat, Cfloat), x, y)
end

function Vector2Zero()
    ccall((:Vector2Zero, raylib), Vector2, ())
end

function Vector2One()
    ccall((:Vector2One, raylib), Vector2, ())
end

function Vector2Add(v1, v2)
    ccall((:Vector2Add, raylib), Vector2, (Vector2, Vector2), v1, v2)
end

function Vector2AddValue(v, add)
    ccall((:Vector2AddValue, raylib), Vector2, (Vector2, Cfloat), v, add)
end

function Vector2Subtract(v1, v2)
    ccall((:Vector2Subtract, raylib), Vector2, (Vector2, Vector2), v1, v2)
end

function Vector2SubtractValue(v, sub)
    ccall((:Vector2SubtractValue, raylib), Vector2, (Vector2, Cfloat), v, sub)
end

function Vector2Length(v)
    ccall((:Vector2Length, raylib), Cfloat, (Vector2,), v)
end

function Vector2LengthSqr(v)
    ccall((:Vector2LengthSqr, raylib), Cfloat, (Vector2,), v)
end

function Vector2DotProduct(v1, v2)
    ccall((:Vector2DotProduct, raylib), Cfloat, (Vector2, Vector2), v1, v2)
end

function Vector2Distance(v1, v2)
    ccall((:Vector2Distance, raylib), Cfloat, (Vector2, Vector2), v1, v2)
end

function Vector2DistanceSqr(v1, v2)
    ccall((:Vector2DistanceSqr, raylib), Cfloat, (Vector2, Vector2), v1, v2)
end

function Vector2Angle(v1, v2)
    ccall((:Vector2Angle, raylib), Cfloat, (Vector2, Vector2), v1, v2)
end

function Vector2LineAngle(start, _end)
    ccall((:Vector2LineAngle, raylib), Cfloat, (Vector2, Vector2), start, _end)
end

function Vector2Scale(v, scale)
    ccall((:Vector2Scale, raylib), Vector2, (Vector2, Cfloat), v, scale)
end

function Vector2Multiply(v1, v2)
    ccall((:Vector2Multiply, raylib), Vector2, (Vector2, Vector2), v1, v2)
end

function Vector2Negate(v)
    ccall((:Vector2Negate, raylib), Vector2, (Vector2,), v)
end

function Vector2Divide(v1, v2)
    ccall((:Vector2Divide, raylib), Vector2, (Vector2, Vector2), v1, v2)
end

function Vector2Normalize(v)
    ccall((:Vector2Normalize, raylib), Vector2, (Vector2,), v)
end

function Vector2Transform(v, mat)
    ccall((:Vector2Transform, raylib), Vector2, (Vector2, Matrix), v, mat)
end

function Vector2Lerp(v1, v2, amount)
    ccall((:Vector2Lerp, raylib), Vector2, (Vector2, Vector2, Cfloat), v1, v2, amount)
end

function Vector2Reflect(v, normal)
    ccall((:Vector2Reflect, raylib), Vector2, (Vector2, Vector2), v, normal)
end

function Vector2Rotate(v, angle)
    ccall((:Vector2Rotate, raylib), Vector2, (Vector2, Cfloat), v, angle)
end

function Vector2MoveTowards(v, target, maxDistance)
    ccall((:Vector2MoveTowards, raylib), Vector2, (Vector2, Vector2, Cfloat), v, target, maxDistance)
end

function Vector2Invert(v)
    ccall((:Vector2Invert, raylib), Vector2, (Vector2,), v)
end

function Vector2Clamp(v, min, max)
    ccall((:Vector2Clamp, raylib), Vector2, (Vector2, Vector2, Vector2), v, min, max)
end

function Vector2ClampValue(v, min, max)
    ccall((:Vector2ClampValue, raylib), Vector2, (Vector2, Cfloat, Cfloat), v, min, max)
end

function Vector2Equals(p, q)
    ccall((:Vector2Equals, raylib), Cint, (Vector2, Vector2), p, q)
end

function Vector3Zero()
    ccall((:Vector3Zero, raylib), Vector3, ())
end

function Vector3One()
    ccall((:Vector3One, raylib), Vector3, ())
end

function Vector3Add(v1, v2)
    ccall((:Vector3Add, raylib), Vector3, (Vector3, Vector3), v1, v2)
end

function Vector3AddValue(v, add)
    ccall((:Vector3AddValue, raylib), Vector3, (Vector3, Cfloat), v, add)
end

function Vector3Subtract(v1, v2)
    ccall((:Vector3Subtract, raylib), Vector3, (Vector3, Vector3), v1, v2)
end

function Vector3SubtractValue(v, sub)
    ccall((:Vector3SubtractValue, raylib), Vector3, (Vector3, Cfloat), v, sub)
end

function Vector3Scale(v, scalar)
    ccall((:Vector3Scale, raylib), Vector3, (Vector3, Cfloat), v, scalar)
end

function Vector3Multiply(v1, v2)
    ccall((:Vector3Multiply, raylib), Vector3, (Vector3, Vector3), v1, v2)
end

function Vector3CrossProduct(v1, v2)
    ccall((:Vector3CrossProduct, raylib), Vector3, (Vector3, Vector3), v1, v2)
end

function Vector3Perpendicular(v)
    ccall((:Vector3Perpendicular, raylib), Vector3, (Vector3,), v)
end

function Vector3Length(v)
    ccall((:Vector3Length, raylib), Cfloat, (Vector3,), v)
end

function Vector3LengthSqr(v)
    ccall((:Vector3LengthSqr, raylib), Cfloat, (Vector3,), v)
end

function Vector3DotProduct(v1, v2)
    ccall((:Vector3DotProduct, raylib), Cfloat, (Vector3, Vector3), v1, v2)
end

function Vector3Distance(v1, v2)
    ccall((:Vector3Distance, raylib), Cfloat, (Vector3, Vector3), v1, v2)
end

function Vector3DistanceSqr(v1, v2)
    ccall((:Vector3DistanceSqr, raylib), Cfloat, (Vector3, Vector3), v1, v2)
end

function Vector3Angle(v1, v2)
    ccall((:Vector3Angle, raylib), Cfloat, (Vector3, Vector3), v1, v2)
end

function Vector3Negate(v)
    ccall((:Vector3Negate, raylib), Vector3, (Vector3,), v)
end

function Vector3Divide(v1, v2)
    ccall((:Vector3Divide, raylib), Vector3, (Vector3, Vector3), v1, v2)
end

function Vector3Normalize(v)
    ccall((:Vector3Normalize, raylib), Vector3, (Vector3,), v)
end

function Vector3Project(v1, v2)
    ccall((:Vector3Project, raylib), Vector3, (Vector3, Vector3), v1, v2)
end

function Vector3Reject(v1, v2)
    ccall((:Vector3Reject, raylib), Vector3, (Vector3, Vector3), v1, v2)
end

function Vector3OrthoNormalize(v1, v2)
    ccall((:Vector3OrthoNormalize, raylib), Cvoid, (Ptr{Vector3}, Ptr{Vector3}), v1, v2)
end

function Vector3Transform(v, mat)
    ccall((:Vector3Transform, raylib), Vector3, (Vector3, Matrix), v, mat)
end

function Vector3RotateByQuaternion(v, q)
    ccall((:Vector3RotateByQuaternion, raylib), Vector3, (Vector3, Quaternion), v, q)
end

function Vector3RotateByAxisAngle(v, axis, angle)
    ccall((:Vector3RotateByAxisAngle, raylib), Vector3, (Vector3, Vector3, Cfloat), v, axis, angle)
end

function Vector3Lerp(v1, v2, amount)
    ccall((:Vector3Lerp, raylib), Vector3, (Vector3, Vector3, Cfloat), v1, v2, amount)
end

function Vector3Reflect(v, normal)
    ccall((:Vector3Reflect, raylib), Vector3, (Vector3, Vector3), v, normal)
end

function Vector3Min(v1, v2)
    ccall((:Vector3Min, raylib), Vector3, (Vector3, Vector3), v1, v2)
end

function Vector3Max(v1, v2)
    ccall((:Vector3Max, raylib), Vector3, (Vector3, Vector3), v1, v2)
end

function Vector3Barycenter(p, a, b, c)
    ccall((:Vector3Barycenter, raylib), Vector3, (Vector3, Vector3, Vector3, Vector3), p, a, b, c)
end

function Vector3Unproject(source, projection, view)
    ccall((:Vector3Unproject, raylib), Vector3, (Vector3, Matrix, Matrix), source, projection, view)
end

function Vector3Invert(v)
    ccall((:Vector3Invert, raylib), Vector3, (Vector3,), v)
end

function Vector3Clamp(v, min, max)
    ccall((:Vector3Clamp, raylib), Vector3, (Vector3, Vector3, Vector3), v, min, max)
end

function Vector3ClampValue(v, min, max)
    ccall((:Vector3ClampValue, raylib), Vector3, (Vector3, Cfloat, Cfloat), v, min, max)
end

function Vector3Equals(p, q)
    ccall((:Vector3Equals, raylib), Cint, (Vector3, Vector3), p, q)
end

function Vector3Refract(v, n, r)
    ccall((:Vector3Refract, raylib), Vector3, (Vector3, Vector3, Cfloat), v, n, r)
end

function MatrixDeterminant(mat)
    ccall((:MatrixDeterminant, raylib), Cfloat, (Matrix,), mat)
end

function MatrixTrace(mat)
    ccall((:MatrixTrace, raylib), Cfloat, (Matrix,), mat)
end

function MatrixTranspose(mat)
    ccall((:MatrixTranspose, raylib), Matrix, (Matrix,), mat)
end

function MatrixInvert(mat)
    ccall((:MatrixInvert, raylib), Matrix, (Matrix,), mat)
end

function MatrixIdentity()
    ccall((:MatrixIdentity, raylib), Matrix, ())
end

function MatrixAdd(left, right)
    ccall((:MatrixAdd, raylib), Matrix, (Matrix, Matrix), left, right)
end

function MatrixSubtract(left, right)
    ccall((:MatrixSubtract, raylib), Matrix, (Matrix, Matrix), left, right)
end

function MatrixMultiply(left, right)
    ccall((:MatrixMultiply, raylib), Matrix, (Matrix, Matrix), left, right)
end

function MatrixTranslate(x, y, z)
    ccall((:MatrixTranslate, raylib), Matrix, (Cfloat, Cfloat, Cfloat), x, y, z)
end

function MatrixRotate(axis, angle)
    ccall((:MatrixRotate, raylib), Matrix, (Vector3, Cfloat), axis, angle)
end

function MatrixRotateX(angle)
    ccall((:MatrixRotateX, raylib), Matrix, (Cfloat,), angle)
end

function MatrixRotateY(angle)
    ccall((:MatrixRotateY, raylib), Matrix, (Cfloat,), angle)
end

function MatrixRotateZ(angle)
    ccall((:MatrixRotateZ, raylib), Matrix, (Cfloat,), angle)
end

function MatrixRotateXYZ(angle)
    ccall((:MatrixRotateXYZ, raylib), Matrix, (Vector3,), angle)
end

function MatrixRotateZYX(angle)
    ccall((:MatrixRotateZYX, raylib), Matrix, (Vector3,), angle)
end

function MatrixScale(x, y, z)
    ccall((:MatrixScale, raylib), Matrix, (Cfloat, Cfloat, Cfloat), x, y, z)
end

function MatrixFrustum(left, right, bottom, top, near, far)
    ccall((:MatrixFrustum, raylib), Matrix, (Cdouble, Cdouble, Cdouble, Cdouble, Cdouble, Cdouble), left, right, bottom, top, near, far)
end

function MatrixPerspective(fovY, aspect, nearPlane, farPlane)
    ccall((:MatrixPerspective, raylib), Matrix, (Cdouble, Cdouble, Cdouble, Cdouble), fovY, aspect, nearPlane, farPlane)
end

function MatrixOrtho(left, right, bottom, top, nearPlane, farPlane)
    ccall((:MatrixOrtho, raylib), Matrix, (Cdouble, Cdouble, Cdouble, Cdouble, Cdouble, Cdouble), left, right, bottom, top, nearPlane, farPlane)
end

function MatrixLookAt(eye, target, up)
    ccall((:MatrixLookAt, raylib), Matrix, (Vector3, Vector3, Vector3), eye, target, up)
end

function QuaternionAdd(q1, q2)
    ccall((:QuaternionAdd, raylib), Quaternion, (Quaternion, Quaternion), q1, q2)
end

function QuaternionAddValue(q, add)
    ccall((:QuaternionAddValue, raylib), Quaternion, (Quaternion, Cfloat), q, add)
end

function QuaternionSubtract(q1, q2)
    ccall((:QuaternionSubtract, raylib), Quaternion, (Quaternion, Quaternion), q1, q2)
end

function QuaternionSubtractValue(q, sub)
    ccall((:QuaternionSubtractValue, raylib), Quaternion, (Quaternion, Cfloat), q, sub)
end

function QuaternionIdentity()
    ccall((:QuaternionIdentity, raylib), Quaternion, ())
end

function QuaternionLength(q)
    ccall((:QuaternionLength, raylib), Cfloat, (Quaternion,), q)
end

function QuaternionNormalize(q)
    ccall((:QuaternionNormalize, raylib), Quaternion, (Quaternion,), q)
end

function QuaternionInvert(q)
    ccall((:QuaternionInvert, raylib), Quaternion, (Quaternion,), q)
end

function QuaternionMultiply(q1, q2)
    ccall((:QuaternionMultiply, raylib), Quaternion, (Quaternion, Quaternion), q1, q2)
end

function QuaternionScale(q, mul)
    ccall((:QuaternionScale, raylib), Quaternion, (Quaternion, Cfloat), q, mul)
end

function QuaternionDivide(q1, q2)
    ccall((:QuaternionDivide, raylib), Quaternion, (Quaternion, Quaternion), q1, q2)
end

function QuaternionLerp(q1, q2, amount)
    ccall((:QuaternionLerp, raylib), Quaternion, (Quaternion, Quaternion, Cfloat), q1, q2, amount)
end

function QuaternionNlerp(q1, q2, amount)
    ccall((:QuaternionNlerp, raylib), Quaternion, (Quaternion, Quaternion, Cfloat), q1, q2, amount)
end

function QuaternionSlerp(q1, q2, amount)
    ccall((:QuaternionSlerp, raylib), Quaternion, (Quaternion, Quaternion, Cfloat), q1, q2, amount)
end

function QuaternionFromVector3ToVector3(from, to)
    ccall((:QuaternionFromVector3ToVector3, raylib), Quaternion, (Vector3, Vector3), from, to)
end

function QuaternionFromMatrix(mat)
    ccall((:QuaternionFromMatrix, raylib), Quaternion, (Matrix,), mat)
end

function QuaternionToMatrix(q)
    ccall((:QuaternionToMatrix, raylib), Matrix, (Quaternion,), q)
end

function QuaternionFromAxisAngle(axis, angle)
    ccall((:QuaternionFromAxisAngle, raylib), Quaternion, (Vector3, Cfloat), axis, angle)
end

function QuaternionToAxisAngle(q, outAxis, outAngle)
    ccall((:QuaternionToAxisAngle, raylib), Cvoid, (Quaternion, Ptr{Vector3}, Ptr{Cfloat}), q, outAxis, outAngle)
end

function QuaternionFromEuler(pitch, yaw, roll)
    ccall((:QuaternionFromEuler, raylib), Quaternion, (Cfloat, Cfloat, Cfloat), pitch, yaw, roll)
end

function QuaternionToEuler(q)
    ccall((:QuaternionToEuler, raylib), Vector3, (Quaternion,), q)
end

function QuaternionTransform(q, mat)
    ccall((:QuaternionTransform, raylib), Quaternion, (Quaternion, Matrix), q, mat)
end

function QuaternionEquals(p, q)
    ccall((:QuaternionEquals, raylib), Cint, (Quaternion, Quaternion), p, q)
end

struct rlVertexBuffer
    elementCount::Cint
    vertices::Ptr{Cfloat}
    texcoords::Ptr{Cfloat}
    colors::Ptr{Cuchar}
    indices::Ptr{Cuint}
    vaoId::Cuint
    vboId::NTuple{4, Cuint}
end

struct rlDrawCall
    mode::Cint
    vertexCount::Cint
    vertexAlignment::Cint
    textureId::Cuint
end

struct rlRenderBatch
    bufferCount::Cint
    currentBuffer::Cint
    vertexBuffer::Ptr{rlVertexBuffer}
    draws::Ptr{rlDrawCall}
    drawCounter::Cint
    currentDepth::Cfloat
end

@cenum rlGlVersion::UInt32 begin
    RL_OPENGL_11 = 1
    RL_OPENGL_21 = 2
    RL_OPENGL_33 = 3
    RL_OPENGL_43 = 4
    RL_OPENGL_ES_20 = 5
    RL_OPENGL_ES_30 = 6
end

@cenum rlTraceLogLevel::UInt32 begin
    RL_LOG_ALL = 0
    RL_LOG_TRACE = 1
    RL_LOG_DEBUG = 2
    RL_LOG_INFO = 3
    RL_LOG_WARNING = 4
    RL_LOG_ERROR = 5
    RL_LOG_FATAL = 6
    RL_LOG_NONE = 7
end

@cenum rlPixelFormat::UInt32 begin
    RL_PIXELFORMAT_UNCOMPRESSED_GRAYSCALE = 1
    RL_PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA = 2
    RL_PIXELFORMAT_UNCOMPRESSED_R5G6B5 = 3
    RL_PIXELFORMAT_UNCOMPRESSED_R8G8B8 = 4
    RL_PIXELFORMAT_UNCOMPRESSED_R5G5B5A1 = 5
    RL_PIXELFORMAT_UNCOMPRESSED_R4G4B4A4 = 6
    RL_PIXELFORMAT_UNCOMPRESSED_R8G8B8A8 = 7
    RL_PIXELFORMAT_UNCOMPRESSED_R32 = 8
    RL_PIXELFORMAT_UNCOMPRESSED_R32G32B32 = 9
    RL_PIXELFORMAT_UNCOMPRESSED_R32G32B32A32 = 10
    RL_PIXELFORMAT_UNCOMPRESSED_R16 = 11
    RL_PIXELFORMAT_UNCOMPRESSED_R16G16B16 = 12
    RL_PIXELFORMAT_UNCOMPRESSED_R16G16B16A16 = 13
    RL_PIXELFORMAT_COMPRESSED_DXT1_RGB = 14
    RL_PIXELFORMAT_COMPRESSED_DXT1_RGBA = 15
    RL_PIXELFORMAT_COMPRESSED_DXT3_RGBA = 16
    RL_PIXELFORMAT_COMPRESSED_DXT5_RGBA = 17
    RL_PIXELFORMAT_COMPRESSED_ETC1_RGB = 18
    RL_PIXELFORMAT_COMPRESSED_ETC2_RGB = 19
    RL_PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA = 20
    RL_PIXELFORMAT_COMPRESSED_PVRT_RGB = 21
    RL_PIXELFORMAT_COMPRESSED_PVRT_RGBA = 22
    RL_PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA = 23
    RL_PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA = 24
end

@cenum rlTextureFilter::UInt32 begin
    RL_TEXTURE_FILTER_POINT = 0
    RL_TEXTURE_FILTER_BILINEAR = 1
    RL_TEXTURE_FILTER_TRILINEAR = 2
    RL_TEXTURE_FILTER_ANISOTROPIC_4X = 3
    RL_TEXTURE_FILTER_ANISOTROPIC_8X = 4
    RL_TEXTURE_FILTER_ANISOTROPIC_16X = 5
end

@cenum rlBlendMode::UInt32 begin
    RL_BLEND_ALPHA = 0
    RL_BLEND_ADDITIVE = 1
    RL_BLEND_MULTIPLIED = 2
    RL_BLEND_ADD_COLORS = 3
    RL_BLEND_SUBTRACT_COLORS = 4
    RL_BLEND_ALPHA_PREMULTIPLY = 5
    RL_BLEND_CUSTOM = 6
    RL_BLEND_CUSTOM_SEPARATE = 7
end

@cenum rlShaderLocationIndex::UInt32 begin
    RL_SHADER_LOC_VERTEX_POSITION = 0
    RL_SHADER_LOC_VERTEX_TEXCOORD01 = 1
    RL_SHADER_LOC_VERTEX_TEXCOORD02 = 2
    RL_SHADER_LOC_VERTEX_NORMAL = 3
    RL_SHADER_LOC_VERTEX_TANGENT = 4
    RL_SHADER_LOC_VERTEX_COLOR = 5
    RL_SHADER_LOC_MATRIX_MVP = 6
    RL_SHADER_LOC_MATRIX_VIEW = 7
    RL_SHADER_LOC_MATRIX_PROJECTION = 8
    RL_SHADER_LOC_MATRIX_MODEL = 9
    RL_SHADER_LOC_MATRIX_NORMAL = 10
    RL_SHADER_LOC_VECTOR_VIEW = 11
    RL_SHADER_LOC_COLOR_DIFFUSE = 12
    RL_SHADER_LOC_COLOR_SPECULAR = 13
    RL_SHADER_LOC_COLOR_AMBIENT = 14
    RL_SHADER_LOC_MAP_ALBEDO = 15
    RL_SHADER_LOC_MAP_METALNESS = 16
    RL_SHADER_LOC_MAP_NORMAL = 17
    RL_SHADER_LOC_MAP_ROUGHNESS = 18
    RL_SHADER_LOC_MAP_OCCLUSION = 19
    RL_SHADER_LOC_MAP_EMISSION = 20
    RL_SHADER_LOC_MAP_HEIGHT = 21
    RL_SHADER_LOC_MAP_CUBEMAP = 22
    RL_SHADER_LOC_MAP_IRRADIANCE = 23
    RL_SHADER_LOC_MAP_PREFILTER = 24
    RL_SHADER_LOC_MAP_BRDF = 25
end

@cenum rlShaderUniformDataType::UInt32 begin
    RL_SHADER_UNIFORM_FLOAT = 0
    RL_SHADER_UNIFORM_VEC2 = 1
    RL_SHADER_UNIFORM_VEC3 = 2
    RL_SHADER_UNIFORM_VEC4 = 3
    RL_SHADER_UNIFORM_INT = 4
    RL_SHADER_UNIFORM_IVEC2 = 5
    RL_SHADER_UNIFORM_IVEC3 = 6
    RL_SHADER_UNIFORM_IVEC4 = 7
    RL_SHADER_UNIFORM_SAMPLER2D = 8
end

@cenum rlShaderAttributeDataType::UInt32 begin
    RL_SHADER_ATTRIB_FLOAT = 0
    RL_SHADER_ATTRIB_VEC2 = 1
    RL_SHADER_ATTRIB_VEC3 = 2
    RL_SHADER_ATTRIB_VEC4 = 3
end

@cenum rlFramebufferAttachType::UInt32 begin
    RL_ATTACHMENT_COLOR_CHANNEL0 = 0
    RL_ATTACHMENT_COLOR_CHANNEL1 = 1
    RL_ATTACHMENT_COLOR_CHANNEL2 = 2
    RL_ATTACHMENT_COLOR_CHANNEL3 = 3
    RL_ATTACHMENT_COLOR_CHANNEL4 = 4
    RL_ATTACHMENT_COLOR_CHANNEL5 = 5
    RL_ATTACHMENT_COLOR_CHANNEL6 = 6
    RL_ATTACHMENT_COLOR_CHANNEL7 = 7
    RL_ATTACHMENT_DEPTH = 100
    RL_ATTACHMENT_STENCIL = 200
end

@cenum rlFramebufferAttachTextureType::UInt32 begin
    RL_ATTACHMENT_CUBEMAP_POSITIVE_X = 0
    RL_ATTACHMENT_CUBEMAP_NEGATIVE_X = 1
    RL_ATTACHMENT_CUBEMAP_POSITIVE_Y = 2
    RL_ATTACHMENT_CUBEMAP_NEGATIVE_Y = 3
    RL_ATTACHMENT_CUBEMAP_POSITIVE_Z = 4
    RL_ATTACHMENT_CUBEMAP_NEGATIVE_Z = 5
    RL_ATTACHMENT_TEXTURE2D = 100
    RL_ATTACHMENT_RENDERBUFFER = 200
end

@cenum rlCullMode::UInt32 begin
    RL_CULL_FACE_FRONT = 0
    RL_CULL_FACE_BACK = 1
end

function rlMatrixMode(mode)
    ccall((:rlMatrixMode, raylib), Cvoid, (Cint,), mode)
end

function rlPushMatrix()
    ccall((:rlPushMatrix, raylib), Cvoid, ())
end

function rlPopMatrix()
    ccall((:rlPopMatrix, raylib), Cvoid, ())
end

function rlLoadIdentity()
    ccall((:rlLoadIdentity, raylib), Cvoid, ())
end

function rlTranslatef(x, y, z)
    ccall((:rlTranslatef, raylib), Cvoid, (Cfloat, Cfloat, Cfloat), x, y, z)
end

function rlRotatef(angle, x, y, z)
    ccall((:rlRotatef, raylib), Cvoid, (Cfloat, Cfloat, Cfloat, Cfloat), angle, x, y, z)
end

function rlScalef(x, y, z)
    ccall((:rlScalef, raylib), Cvoid, (Cfloat, Cfloat, Cfloat), x, y, z)
end

function rlMultMatrixf(matf)
    ccall((:rlMultMatrixf, raylib), Cvoid, (Ptr{Cfloat},), matf)
end

function rlFrustum(left, right, bottom, top, znear, zfar)
    ccall((:rlFrustum, raylib), Cvoid, (Cdouble, Cdouble, Cdouble, Cdouble, Cdouble, Cdouble), left, right, bottom, top, znear, zfar)
end

function rlOrtho(left, right, bottom, top, znear, zfar)
    ccall((:rlOrtho, raylib), Cvoid, (Cdouble, Cdouble, Cdouble, Cdouble, Cdouble, Cdouble), left, right, bottom, top, znear, zfar)
end

function rlViewport(x, y, width, height)
    ccall((:rlViewport, raylib), Cvoid, (Cint, Cint, Cint, Cint), x, y, width, height)
end

function rlBegin(mode)
    ccall((:rlBegin, raylib), Cvoid, (Cint,), mode)
end

function rlEnd()
    ccall((:rlEnd, raylib), Cvoid, ())
end

function rlVertex2i(x, y)
    ccall((:rlVertex2i, raylib), Cvoid, (Cint, Cint), x, y)
end

function rlVertex2f(x, y)
    ccall((:rlVertex2f, raylib), Cvoid, (Cfloat, Cfloat), x, y)
end

function rlVertex3f(x, y, z)
    ccall((:rlVertex3f, raylib), Cvoid, (Cfloat, Cfloat, Cfloat), x, y, z)
end

function rlTexCoord2f(x, y)
    ccall((:rlTexCoord2f, raylib), Cvoid, (Cfloat, Cfloat), x, y)
end

function rlNormal3f(x, y, z)
    ccall((:rlNormal3f, raylib), Cvoid, (Cfloat, Cfloat, Cfloat), x, y, z)
end

function rlColor4ub(r, g, b, a)
    ccall((:rlColor4ub, raylib), Cvoid, (Cuchar, Cuchar, Cuchar, Cuchar), r, g, b, a)
end

function rlColor3f(x, y, z)
    ccall((:rlColor3f, raylib), Cvoid, (Cfloat, Cfloat, Cfloat), x, y, z)
end

function rlColor4f(x, y, z, w)
    ccall((:rlColor4f, raylib), Cvoid, (Cfloat, Cfloat, Cfloat, Cfloat), x, y, z, w)
end

function rlEnableVertexArray(vaoId)
    ccall((:rlEnableVertexArray, raylib), Bool, (Cuint,), vaoId)
end

function rlDisableVertexArray()
    ccall((:rlDisableVertexArray, raylib), Cvoid, ())
end

function rlEnableVertexBuffer(id)
    ccall((:rlEnableVertexBuffer, raylib), Cvoid, (Cuint,), id)
end

function rlDisableVertexBuffer()
    ccall((:rlDisableVertexBuffer, raylib), Cvoid, ())
end

function rlEnableVertexBufferElement(id)
    ccall((:rlEnableVertexBufferElement, raylib), Cvoid, (Cuint,), id)
end

function rlDisableVertexBufferElement()
    ccall((:rlDisableVertexBufferElement, raylib), Cvoid, ())
end

function rlEnableVertexAttribute(index)
    ccall((:rlEnableVertexAttribute, raylib), Cvoid, (Cuint,), index)
end

function rlDisableVertexAttribute(index)
    ccall((:rlDisableVertexAttribute, raylib), Cvoid, (Cuint,), index)
end

function rlActiveTextureSlot(slot)
    ccall((:rlActiveTextureSlot, raylib), Cvoid, (Cint,), slot)
end

function rlEnableTexture(id)
    ccall((:rlEnableTexture, raylib), Cvoid, (Cuint,), id)
end

function rlDisableTexture()
    ccall((:rlDisableTexture, raylib), Cvoid, ())
end

function rlEnableTextureCubemap(id)
    ccall((:rlEnableTextureCubemap, raylib), Cvoid, (Cuint,), id)
end

function rlDisableTextureCubemap()
    ccall((:rlDisableTextureCubemap, raylib), Cvoid, ())
end

function rlTextureParameters(id, param, value)
    ccall((:rlTextureParameters, raylib), Cvoid, (Cuint, Cint, Cint), id, param, value)
end

function rlCubemapParameters(id, param, value)
    ccall((:rlCubemapParameters, raylib), Cvoid, (Cuint, Cint, Cint), id, param, value)
end

function rlEnableShader(id)
    ccall((:rlEnableShader, raylib), Cvoid, (Cuint,), id)
end

function rlDisableShader()
    ccall((:rlDisableShader, raylib), Cvoid, ())
end

function rlEnableFramebuffer(id)
    ccall((:rlEnableFramebuffer, raylib), Cvoid, (Cuint,), id)
end

function rlDisableFramebuffer()
    ccall((:rlDisableFramebuffer, raylib), Cvoid, ())
end

function rlActiveDrawBuffers(count)
    ccall((:rlActiveDrawBuffers, raylib), Cvoid, (Cint,), count)
end

function rlBlitFramebuffer(srcX, srcY, srcWidth, srcHeight, dstX, dstY, dstWidth, dstHeight, bufferMask)
    ccall((:rlBlitFramebuffer, raylib), Cvoid, (Cint, Cint, Cint, Cint, Cint, Cint, Cint, Cint, Cint), srcX, srcY, srcWidth, srcHeight, dstX, dstY, dstWidth, dstHeight, bufferMask)
end

function rlEnableColorBlend()
    ccall((:rlEnableColorBlend, raylib), Cvoid, ())
end

function rlDisableColorBlend()
    ccall((:rlDisableColorBlend, raylib), Cvoid, ())
end

function rlEnableDepthTest()
    ccall((:rlEnableDepthTest, raylib), Cvoid, ())
end

function rlDisableDepthTest()
    ccall((:rlDisableDepthTest, raylib), Cvoid, ())
end

function rlEnableDepthMask()
    ccall((:rlEnableDepthMask, raylib), Cvoid, ())
end

function rlDisableDepthMask()
    ccall((:rlDisableDepthMask, raylib), Cvoid, ())
end

function rlEnableBackfaceCulling()
    ccall((:rlEnableBackfaceCulling, raylib), Cvoid, ())
end

function rlDisableBackfaceCulling()
    ccall((:rlDisableBackfaceCulling, raylib), Cvoid, ())
end

function rlSetCullFace(mode)
    ccall((:rlSetCullFace, raylib), Cvoid, (Cint,), mode)
end

function rlEnableScissorTest()
    ccall((:rlEnableScissorTest, raylib), Cvoid, ())
end

function rlDisableScissorTest()
    ccall((:rlDisableScissorTest, raylib), Cvoid, ())
end

function rlScissor(x, y, width, height)
    ccall((:rlScissor, raylib), Cvoid, (Cint, Cint, Cint, Cint), x, y, width, height)
end

function rlEnableWireMode()
    ccall((:rlEnableWireMode, raylib), Cvoid, ())
end

function rlEnablePointMode()
    ccall((:rlEnablePointMode, raylib), Cvoid, ())
end

function rlDisableWireMode()
    ccall((:rlDisableWireMode, raylib), Cvoid, ())
end

function rlSetLineWidth(width)
    ccall((:rlSetLineWidth, raylib), Cvoid, (Cfloat,), width)
end

function rlGetLineWidth()
    ccall((:rlGetLineWidth, raylib), Cfloat, ())
end

function rlEnableSmoothLines()
    ccall((:rlEnableSmoothLines, raylib), Cvoid, ())
end

function rlDisableSmoothLines()
    ccall((:rlDisableSmoothLines, raylib), Cvoid, ())
end

function rlEnableStereoRender()
    ccall((:rlEnableStereoRender, raylib), Cvoid, ())
end

function rlDisableStereoRender()
    ccall((:rlDisableStereoRender, raylib), Cvoid, ())
end

function rlIsStereoRenderEnabled()
    ccall((:rlIsStereoRenderEnabled, raylib), Bool, ())
end

function rlClearColor(r, g, b, a)
    ccall((:rlClearColor, raylib), Cvoid, (Cuchar, Cuchar, Cuchar, Cuchar), r, g, b, a)
end

function rlClearScreenBuffers()
    ccall((:rlClearScreenBuffers, raylib), Cvoid, ())
end

function rlCheckErrors()
    ccall((:rlCheckErrors, raylib), Cvoid, ())
end

function rlSetBlendMode(mode)
    ccall((:rlSetBlendMode, raylib), Cvoid, (Cint,), mode)
end

function rlSetBlendFactors(glSrcFactor, glDstFactor, glEquation)
    ccall((:rlSetBlendFactors, raylib), Cvoid, (Cint, Cint, Cint), glSrcFactor, glDstFactor, glEquation)
end

function rlSetBlendFactorsSeparate(glSrcRGB, glDstRGB, glSrcAlpha, glDstAlpha, glEqRGB, glEqAlpha)
    ccall((:rlSetBlendFactorsSeparate, raylib), Cvoid, (Cint, Cint, Cint, Cint, Cint, Cint), glSrcRGB, glDstRGB, glSrcAlpha, glDstAlpha, glEqRGB, glEqAlpha)
end

function rlglInit(width, height)
    ccall((:rlglInit, raylib), Cvoid, (Cint, Cint), width, height)
end

function rlglClose()
    ccall((:rlglClose, raylib), Cvoid, ())
end

function rlLoadExtensions(loader)
    ccall((:rlLoadExtensions, raylib), Cvoid, (Ptr{Cvoid},), loader)
end

function rlGetVersion()
    ccall((:rlGetVersion, raylib), Cint, ())
end

function rlSetFramebufferWidth(width)
    ccall((:rlSetFramebufferWidth, raylib), Cvoid, (Cint,), width)
end

function rlGetFramebufferWidth()
    ccall((:rlGetFramebufferWidth, raylib), Cint, ())
end

function rlSetFramebufferHeight(height)
    ccall((:rlSetFramebufferHeight, raylib), Cvoid, (Cint,), height)
end

function rlGetFramebufferHeight()
    ccall((:rlGetFramebufferHeight, raylib), Cint, ())
end

function rlGetTextureIdDefault()
    ccall((:rlGetTextureIdDefault, raylib), Cuint, ())
end

function rlGetShaderIdDefault()
    ccall((:rlGetShaderIdDefault, raylib), Cuint, ())
end

function rlGetShaderLocsDefault()
    ccall((:rlGetShaderLocsDefault, raylib), Ptr{Cint}, ())
end

function rlLoadRenderBatch(numBuffers, bufferElements)
    ccall((:rlLoadRenderBatch, raylib), rlRenderBatch, (Cint, Cint), numBuffers, bufferElements)
end

function rlUnloadRenderBatch(batch)
    ccall((:rlUnloadRenderBatch, raylib), Cvoid, (rlRenderBatch,), batch)
end

function rlDrawRenderBatch(batch)
    ccall((:rlDrawRenderBatch, raylib), Cvoid, (Ptr{rlRenderBatch},), batch)
end

function rlSetRenderBatchActive(batch)
    ccall((:rlSetRenderBatchActive, raylib), Cvoid, (Ptr{rlRenderBatch},), batch)
end

function rlDrawRenderBatchActive()
    ccall((:rlDrawRenderBatchActive, raylib), Cvoid, ())
end

function rlCheckRenderBatchLimit(vCount)
    ccall((:rlCheckRenderBatchLimit, raylib), Bool, (Cint,), vCount)
end

function rlSetTexture(id)
    ccall((:rlSetTexture, raylib), Cvoid, (Cuint,), id)
end

function rlLoadVertexArray()
    ccall((:rlLoadVertexArray, raylib), Cuint, ())
end

function rlLoadVertexBuffer(buffer, size, dynamic)
    ccall((:rlLoadVertexBuffer, raylib), Cuint, (Ptr{Cvoid}, Cint, Bool), buffer, size, dynamic)
end

function rlLoadVertexBufferElement(buffer, size, dynamic)
    ccall((:rlLoadVertexBufferElement, raylib), Cuint, (Ptr{Cvoid}, Cint, Bool), buffer, size, dynamic)
end

function rlUpdateVertexBuffer(bufferId, data, dataSize, offset)
    ccall((:rlUpdateVertexBuffer, raylib), Cvoid, (Cuint, Ptr{Cvoid}, Cint, Cint), bufferId, data, dataSize, offset)
end

function rlUpdateVertexBufferElements(id, data, dataSize, offset)
    ccall((:rlUpdateVertexBufferElements, raylib), Cvoid, (Cuint, Ptr{Cvoid}, Cint, Cint), id, data, dataSize, offset)
end

function rlUnloadVertexArray(vaoId)
    ccall((:rlUnloadVertexArray, raylib), Cvoid, (Cuint,), vaoId)
end

function rlUnloadVertexBuffer(vboId)
    ccall((:rlUnloadVertexBuffer, raylib), Cvoid, (Cuint,), vboId)
end

function rlSetVertexAttribute(index, compSize, type, normalized, stride, pointer)
    ccall((:rlSetVertexAttribute, raylib), Cvoid, (Cuint, Cint, Cint, Bool, Cint, Ptr{Cvoid}), index, compSize, type, normalized, stride, pointer)
end

function rlSetVertexAttributeDivisor(index, divisor)
    ccall((:rlSetVertexAttributeDivisor, raylib), Cvoid, (Cuint, Cint), index, divisor)
end

function rlSetVertexAttributeDefault(locIndex, value, attribType, count)
    ccall((:rlSetVertexAttributeDefault, raylib), Cvoid, (Cint, Ptr{Cvoid}, Cint, Cint), locIndex, value, attribType, count)
end

function rlDrawVertexArray(offset, count)
    ccall((:rlDrawVertexArray, raylib), Cvoid, (Cint, Cint), offset, count)
end

function rlDrawVertexArrayElements(offset, count, buffer)
    ccall((:rlDrawVertexArrayElements, raylib), Cvoid, (Cint, Cint, Ptr{Cvoid}), offset, count, buffer)
end

function rlDrawVertexArrayInstanced(offset, count, instances)
    ccall((:rlDrawVertexArrayInstanced, raylib), Cvoid, (Cint, Cint, Cint), offset, count, instances)
end

function rlDrawVertexArrayElementsInstanced(offset, count, buffer, instances)
    ccall((:rlDrawVertexArrayElementsInstanced, raylib), Cvoid, (Cint, Cint, Ptr{Cvoid}, Cint), offset, count, buffer, instances)
end

function rlLoadTexture(data, width, height, format, mipmapCount)
    ccall((:rlLoadTexture, raylib), Cuint, (Ptr{Cvoid}, Cint, Cint, Cint, Cint), data, width, height, format, mipmapCount)
end

function rlLoadTextureDepth(width, height, useRenderBuffer)
    ccall((:rlLoadTextureDepth, raylib), Cuint, (Cint, Cint, Bool), width, height, useRenderBuffer)
end

function rlLoadTextureCubemap(data, size, format)
    ccall((:rlLoadTextureCubemap, raylib), Cuint, (Ptr{Cvoid}, Cint, Cint), data, size, format)
end

function rlUpdateTexture(id, offsetX, offsetY, width, height, format, data)
    ccall((:rlUpdateTexture, raylib), Cvoid, (Cuint, Cint, Cint, Cint, Cint, Cint, Ptr{Cvoid}), id, offsetX, offsetY, width, height, format, data)
end

function rlGetGlTextureFormats(format, glInternalFormat, glFormat, glType)
    ccall((:rlGetGlTextureFormats, raylib), Cvoid, (Cint, Ptr{Cuint}, Ptr{Cuint}, Ptr{Cuint}), format, glInternalFormat, glFormat, glType)
end

function rlGetPixelFormatName(format)
    ccall((:rlGetPixelFormatName, raylib), Ptr{Cchar}, (Cuint,), format)
end

function rlUnloadTexture(id)
    ccall((:rlUnloadTexture, raylib), Cvoid, (Cuint,), id)
end

function rlGenTextureMipmaps(id, width, height, format, mipmaps)
    ccall((:rlGenTextureMipmaps, raylib), Cvoid, (Cuint, Cint, Cint, Cint, Ptr{Cint}), id, width, height, format, mipmaps)
end

function rlReadTexturePixels(id, width, height, format)
    ccall((:rlReadTexturePixels, raylib), Ptr{Cvoid}, (Cuint, Cint, Cint, Cint), id, width, height, format)
end

function rlReadScreenPixels(width, height)
    ccall((:rlReadScreenPixels, raylib), Ptr{Cuchar}, (Cint, Cint), width, height)
end

function rlLoadFramebuffer(width, height)
    ccall((:rlLoadFramebuffer, raylib), Cuint, (Cint, Cint), width, height)
end

function rlFramebufferAttach(fboId, texId, attachType, texType, mipLevel)
    ccall((:rlFramebufferAttach, raylib), Cvoid, (Cuint, Cuint, Cint, Cint, Cint), fboId, texId, attachType, texType, mipLevel)
end

function rlFramebufferComplete(id)
    ccall((:rlFramebufferComplete, raylib), Bool, (Cuint,), id)
end

function rlUnloadFramebuffer(id)
    ccall((:rlUnloadFramebuffer, raylib), Cvoid, (Cuint,), id)
end

function rlLoadShaderCode(vsCode, fsCode)
    ccall((:rlLoadShaderCode, raylib), Cuint, (Ptr{Cchar}, Ptr{Cchar}), vsCode, fsCode)
end

function rlCompileShader(shaderCode, type)
    ccall((:rlCompileShader, raylib), Cuint, (Ptr{Cchar}, Cint), shaderCode, type)
end

function rlLoadShaderProgram(vShaderId, fShaderId)
    ccall((:rlLoadShaderProgram, raylib), Cuint, (Cuint, Cuint), vShaderId, fShaderId)
end

function rlUnloadShaderProgram(id)
    ccall((:rlUnloadShaderProgram, raylib), Cvoid, (Cuint,), id)
end

function rlGetLocationUniform(shaderId, uniformName)
    ccall((:rlGetLocationUniform, raylib), Cint, (Cuint, Ptr{Cchar}), shaderId, uniformName)
end

function rlGetLocationAttrib(shaderId, attribName)
    ccall((:rlGetLocationAttrib, raylib), Cint, (Cuint, Ptr{Cchar}), shaderId, attribName)
end

function rlSetUniform(locIndex, value, uniformType, count)
    ccall((:rlSetUniform, raylib), Cvoid, (Cint, Ptr{Cvoid}, Cint, Cint), locIndex, value, uniformType, count)
end

function rlSetUniformMatrix(locIndex, mat)
    ccall((:rlSetUniformMatrix, raylib), Cvoid, (Cint, Matrix), locIndex, mat)
end

function rlSetUniformSampler(locIndex, textureId)
    ccall((:rlSetUniformSampler, raylib), Cvoid, (Cint, Cuint), locIndex, textureId)
end

function rlSetShader(id, locs)
    ccall((:rlSetShader, raylib), Cvoid, (Cuint, Ptr{Cint}), id, locs)
end

function rlLoadComputeShaderProgram(shaderId)
    ccall((:rlLoadComputeShaderProgram, raylib), Cuint, (Cuint,), shaderId)
end

function rlComputeShaderDispatch(groupX, groupY, groupZ)
    ccall((:rlComputeShaderDispatch, raylib), Cvoid, (Cuint, Cuint, Cuint), groupX, groupY, groupZ)
end

function rlLoadShaderBuffer(size, data, usageHint)
    ccall((:rlLoadShaderBuffer, raylib), Cuint, (Cuint, Ptr{Cvoid}, Cint), size, data, usageHint)
end

function rlUnloadShaderBuffer(ssboId)
    ccall((:rlUnloadShaderBuffer, raylib), Cvoid, (Cuint,), ssboId)
end

function rlUpdateShaderBuffer(id, data, dataSize, offset)
    ccall((:rlUpdateShaderBuffer, raylib), Cvoid, (Cuint, Ptr{Cvoid}, Cuint, Cuint), id, data, dataSize, offset)
end

function rlBindShaderBuffer(id, index)
    ccall((:rlBindShaderBuffer, raylib), Cvoid, (Cuint, Cuint), id, index)
end

function rlReadShaderBuffer(id, dest, count, offset)
    ccall((:rlReadShaderBuffer, raylib), Cvoid, (Cuint, Ptr{Cvoid}, Cuint, Cuint), id, dest, count, offset)
end

function rlCopyShaderBuffer(destId, srcId, destOffset, srcOffset, count)
    ccall((:rlCopyShaderBuffer, raylib), Cvoid, (Cuint, Cuint, Cuint, Cuint, Cuint), destId, srcId, destOffset, srcOffset, count)
end

function rlGetShaderBufferSize(id)
    ccall((:rlGetShaderBufferSize, raylib), Cuint, (Cuint,), id)
end

function rlBindImageTexture(id, index, format, readonly)
    ccall((:rlBindImageTexture, raylib), Cvoid, (Cuint, Cuint, Cint, Bool), id, index, format, readonly)
end

function rlGetMatrixModelview()
    ccall((:rlGetMatrixModelview, raylib), Matrix, ())
end

function rlGetMatrixProjection()
    ccall((:rlGetMatrixProjection, raylib), Matrix, ())
end

function rlGetMatrixTransform()
    ccall((:rlGetMatrixTransform, raylib), Matrix, ())
end

function rlGetMatrixProjectionStereo(eye)
    ccall((:rlGetMatrixProjectionStereo, raylib), Matrix, (Cint,), eye)
end

function rlGetMatrixViewOffsetStereo(eye)
    ccall((:rlGetMatrixViewOffsetStereo, raylib), Matrix, (Cint,), eye)
end

function rlSetMatrixProjection(proj)
    ccall((:rlSetMatrixProjection, raylib), Cvoid, (Matrix,), proj)
end

function rlSetMatrixModelview(view)
    ccall((:rlSetMatrixModelview, raylib), Cvoid, (Matrix,), view)
end

function rlSetMatrixProjectionStereo(right, left)
    ccall((:rlSetMatrixProjectionStereo, raylib), Cvoid, (Matrix, Matrix), right, left)
end

function rlSetMatrixViewOffsetStereo(right, left)
    ccall((:rlSetMatrixViewOffsetStereo, raylib), Cvoid, (Matrix, Matrix), right, left)
end

function rlLoadDrawCube()
    ccall((:rlLoadDrawCube, raylib), Cvoid, ())
end

function rlLoadDrawQuad()
    ccall((:rlLoadDrawQuad, raylib), Cvoid, ())
end

const RAYLIB_VERSION_MAJOR = 5

const RAYLIB_VERSION_MINOR = 0

const RAYLIB_VERSION_PATCH = 0

const RAYLIB_VERSION = "5.0"

const PI = Float32(3.141592653589793)

const DEG2RAD = PI ÷ Float32(180.0)

const RAD2DEG = Float32(180.0) ÷ PI

# Skipping MacroDefinition: LIGHTGRAY CLITERAL ( Color ) { 200 , 200 , 200 , 255 }

# Skipping MacroDefinition: GRAY CLITERAL ( Color ) { 130 , 130 , 130 , 255 }

# Skipping MacroDefinition: DARKGRAY CLITERAL ( Color ) { 80 , 80 , 80 , 255 }

# Skipping MacroDefinition: YELLOW CLITERAL ( Color ) { 253 , 249 , 0 , 255 }

# Skipping MacroDefinition: GOLD CLITERAL ( Color ) { 255 , 203 , 0 , 255 }

# Skipping MacroDefinition: ORANGE CLITERAL ( Color ) { 255 , 161 , 0 , 255 }

# Skipping MacroDefinition: PINK CLITERAL ( Color ) { 255 , 109 , 194 , 255 }

# Skipping MacroDefinition: RED CLITERAL ( Color ) { 230 , 41 , 55 , 255 }

# Skipping MacroDefinition: MAROON CLITERAL ( Color ) { 190 , 33 , 55 , 255 }

# Skipping MacroDefinition: GREEN CLITERAL ( Color ) { 0 , 228 , 48 , 255 }

# Skipping MacroDefinition: LIME CLITERAL ( Color ) { 0 , 158 , 47 , 255 }

# Skipping MacroDefinition: DARKGREEN CLITERAL ( Color ) { 0 , 117 , 44 , 255 }

# Skipping MacroDefinition: SKYBLUE CLITERAL ( Color ) { 102 , 191 , 255 , 255 }

# Skipping MacroDefinition: BLUE CLITERAL ( Color ) { 0 , 121 , 241 , 255 }

# Skipping MacroDefinition: DARKBLUE CLITERAL ( Color ) { 0 , 82 , 172 , 255 }

# Skipping MacroDefinition: PURPLE CLITERAL ( Color ) { 200 , 122 , 255 , 255 }

# Skipping MacroDefinition: VIOLET CLITERAL ( Color ) { 135 , 60 , 190 , 255 }

# Skipping MacroDefinition: DARKPURPLE CLITERAL ( Color ) { 112 , 31 , 126 , 255 }

# Skipping MacroDefinition: BEIGE CLITERAL ( Color ) { 211 , 176 , 131 , 255 }

# Skipping MacroDefinition: BROWN CLITERAL ( Color ) { 127 , 106 , 79 , 255 }

# Skipping MacroDefinition: DARKBROWN CLITERAL ( Color ) { 76 , 63 , 47 , 255 }

# Skipping MacroDefinition: WHITE CLITERAL ( Color ) { 255 , 255 , 255 , 255 }

# Skipping MacroDefinition: BLACK CLITERAL ( Color ) { 0 , 0 , 0 , 255 }

# Skipping MacroDefinition: BLANK CLITERAL ( Color ) { 0 , 0 , 0 , 0 }

# Skipping MacroDefinition: MAGENTA CLITERAL ( Color ) { 255 , 0 , 255 , 255 }

# Skipping MacroDefinition: RAYWHITE CLITERAL ( Color ) { 245 , 245 , 245 , 255 }

const MOUSE_LEFT_BUTTON = MOUSE_BUTTON_LEFT

const MOUSE_RIGHT_BUTTON = MOUSE_BUTTON_RIGHT

const MOUSE_MIDDLE_BUTTON = MOUSE_BUTTON_MIDDLE

const MATERIAL_MAP_DIFFUSE = MATERIAL_MAP_ALBEDO

const MATERIAL_MAP_SPECULAR = MATERIAL_MAP_METALNESS

const SHADER_LOC_MAP_DIFFUSE = SHADER_LOC_MAP_ALBEDO

const SHADER_LOC_MAP_SPECULAR = SHADER_LOC_MAP_METALNESS

# Skipping MacroDefinition: RMAPI inline

const EPSILON = Float32(1.0e-6)

const RLGL_VERSION = "4.5"

const RL_DEFAULT_BATCH_BUFFER_ELEMENTS = 8192

const RL_DEFAULT_BATCH_BUFFERS = 1

const RL_DEFAULT_BATCH_DRAWCALLS = 256

const RL_DEFAULT_BATCH_MAX_TEXTURE_UNITS = 4

const RL_MAX_MATRIX_STACK_SIZE = 32

const RL_MAX_SHADER_LOCATIONS = 32

const RL_CULL_DISTANCE_NEAR = 0.01

const RL_CULL_DISTANCE_FAR = 1000.0

const RL_TEXTURE_WRAP_S = 0x2802

const RL_TEXTURE_WRAP_T = 0x2803

const RL_TEXTURE_MAG_FILTER = 0x2800

const RL_TEXTURE_MIN_FILTER = 0x2801

const RL_TEXTURE_FILTER_NEAREST = 0x2600

const RL_TEXTURE_FILTER_LINEAR = 0x2601

const RL_TEXTURE_FILTER_MIP_NEAREST = 0x2700

const RL_TEXTURE_FILTER_NEAREST_MIP_LINEAR = 0x2702

const RL_TEXTURE_FILTER_LINEAR_MIP_NEAREST = 0x2701

const RL_TEXTURE_FILTER_MIP_LINEAR = 0x2703

const RL_TEXTURE_FILTER_ANISOTROPIC = 0x3000

const RL_TEXTURE_MIPMAP_BIAS_RATIO = 0x4000

const RL_TEXTURE_WRAP_REPEAT = 0x2901

const RL_TEXTURE_WRAP_CLAMP = 0x812f

const RL_TEXTURE_WRAP_MIRROR_REPEAT = 0x8370

const RL_TEXTURE_WRAP_MIRROR_CLAMP = 0x8742

const RL_MODELVIEW = 0x1700

const RL_PROJECTION = 0x1701

const RL_TEXTURE = 0x1702

const RL_LINES = 0x0001

const RL_TRIANGLES = 0x0004

const RL_QUADS = 0x0007

const RL_UNSIGNED_BYTE = 0x1401

const RL_FLOAT = 0x1406

const RL_STREAM_DRAW = 0x88e0

const RL_STREAM_READ = 0x88e1

const RL_STREAM_COPY = 0x88e2

const RL_STATIC_DRAW = 0x88e4

const RL_STATIC_READ = 0x88e5

const RL_STATIC_COPY = 0x88e6

const RL_DYNAMIC_DRAW = 0x88e8

const RL_DYNAMIC_READ = 0x88e9

const RL_DYNAMIC_COPY = 0x88ea

const RL_FRAGMENT_SHADER = 0x8b30

const RL_VERTEX_SHADER = 0x8b31

const RL_COMPUTE_SHADER = 0x91b9

const RL_ZERO = 0

const RL_ONE = 1

const RL_SRC_COLOR = 0x0300

const RL_ONE_MINUS_SRC_COLOR = 0x0301

const RL_SRC_ALPHA = 0x0302

const RL_ONE_MINUS_SRC_ALPHA = 0x0303

const RL_DST_ALPHA = 0x0304

const RL_ONE_MINUS_DST_ALPHA = 0x0305

const RL_DST_COLOR = 0x0306

const RL_ONE_MINUS_DST_COLOR = 0x0307

const RL_SRC_ALPHA_SATURATE = 0x0308

const RL_CONSTANT_COLOR = 0x8001

const RL_ONE_MINUS_CONSTANT_COLOR = 0x8002

const RL_CONSTANT_ALPHA = 0x8003

const RL_ONE_MINUS_CONSTANT_ALPHA = 0x8004

const RL_FUNC_ADD = 0x8006

const RL_MIN = 0x8007

const RL_MAX = 0x8008

const RL_FUNC_SUBTRACT = 0x800a

const RL_FUNC_REVERSE_SUBTRACT = 0x800b

const RL_BLEND_EQUATION = 0x8009

const RL_BLEND_EQUATION_RGB = 0x8009

const RL_BLEND_EQUATION_ALPHA = 0x883d

const RL_BLEND_DST_RGB = 0x80c8

const RL_BLEND_SRC_RGB = 0x80c9

const RL_BLEND_DST_ALPHA = 0x80ca

const RL_BLEND_SRC_ALPHA = 0x80cb

const RL_BLEND_COLOR = 0x8005

const RL_SHADER_LOC_MAP_DIFFUSE = RL_SHADER_LOC_MAP_ALBEDO

const RL_SHADER_LOC_MAP_SPECULAR = RL_SHADER_LOC_MAP_METALNESS

# exports
const PREFIXES = ["raylib_"]
for name in names(@__MODULE__; all=true), prefix in PREFIXES
    if startswith(string(name), prefix)
        @eval export $name
    end
end

end
