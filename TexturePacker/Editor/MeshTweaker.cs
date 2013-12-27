/*
	Mesh Tools - Mesh Tweaker
    Copyright (C) 2013 Mitch Thompson

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

using UnityEngine;
using UnityEditor;
using System.Collections;
using System.Collections.Generic;

public class MeshTweaker{
	
	
	
	
	
	[MenuItem("Assets/MeshTweaker/Rotate/X45")]
	static void RotateX45(){BatchRotate(45,0,0);}
	[MenuItem("Assets/MeshTweaker/Rotate/X90")]
	static void RotateX90(){BatchRotate(90,0,0);}
	
	[MenuItem("Assets/MeshTweaker/Rotate/Y45")]
	static void RotateY45(){BatchRotate(0,45,0);}
	[MenuItem("Assets/MeshTweaker/Rotate/Y90")]
	static void RotateY90(){BatchRotate(0,90,0);}
	
	[MenuItem("Assets/MeshTweaker/Rotate/Z45")]
	static void RotateZ45(){BatchRotate(0,0,45);}
	[MenuItem("Assets/MeshTweaker/Rotate/Z90")]
	static void RotateZ90(){BatchRotate(0,0,90);}
	
	static void BatchRotate(float x, float y, float z){
		Quaternion quat = Quaternion.Euler(x,y,z);
		foreach(Object o in Selection.objects){
			if(o is Mesh){
				RotateMesh(o as Mesh, quat);
			}
		}	
	}
	
	
	static void RotateMesh(Mesh mesh, Quaternion quat){
		Vector3[] verts = mesh.vertices;
		for(int i = 0; i < verts.Length; i++){
			verts[i] = quat * verts[i];	
		}
		
		mesh.vertices = verts;
		
		mesh.RecalculateNormals();
		
		EditorUtility.SetDirty(mesh);
	}
	
	
	[MenuItem("Assets/MeshTweaker/Align/Center")]
	static void BatchCenter(){
		foreach(Object o in Selection.objects){
			if(o is Mesh){
				CenterMesh(o as Mesh);
			}
		}
	}
	
	static void CenterMesh(Mesh mesh){
		Vector3[] verts = mesh.vertices;
		
		Vector3 min = new Vector3(float.MaxValue, float.MaxValue, float.MaxValue);
		Vector3 max = new Vector3(float.MinValue, float.MinValue, float.MinValue);
		
		foreach(Vector3 v in verts){
			if(v.x < min.x) min.x = v.x;
			else if(v.x > max.x) max.x = v.x;
			
			if(v.y < min.y) min.y = v.y;
			else if(v.y > max.y) max.y = v.y;
			
			if(v.z < min.z) min.z = v.z;
			else if(v.z > max.z) max.z = v.z;
		}
		
		Vector3 average = (min + max) * 0.5f;
		
		for(int i = 0; i < verts.Length; i++){
			verts[i] = verts[i] + ( Vector3.zero - average );
		}
		
		mesh.vertices = verts;
		EditorUtility.SetDirty(mesh);
	}
}