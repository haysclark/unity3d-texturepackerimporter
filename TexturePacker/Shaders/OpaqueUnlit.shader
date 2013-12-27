Shader "Sprites/Opaque Unlit" 
{
    Properties 
    {
        _Color ("Color Tint", Color) = (1,1,1,1)    
        _MainTex ("Base (RGB)", 2D) = "white"
    }

    Category 
    {
        Lighting Off
		ZWrite On
        Cull back
        Tags {Queue=Geometry}

        SubShader 
        {

             Pass 
             {
                        SetTexture [_MainTex] 
                        {
                    ConstantColor [_Color]
                   Combine Texture * constant
                }
            }
        }
    }
}