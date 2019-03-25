/*******************************************************************************************
*
*   raylib [core] example - 3d camera first person
*
*   This example has been created using raylib 1.3 (www.raylib.com)
*   raylib is licensed under an unmodified zlib/libpng license (View raylib.h for details)
*
*   Copyright (c) 2015 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

package examples.core;

import raylib.Raylib;
import raylib.Raylib.*;

class Core3DCameraFirstPerson
{
	static inline var MAX_COLUMNS = 20;

	static function main()
	{
		// Initialization
		//--------------------------------------------------------------------------------------
		var screenWidth = 800;
		var screenHeight = 450;

		InitWindow(screenWidth, screenHeight, "raylib [core] example - 3d camera first person");

		// Define the camera to look into our 3d world (position, target, up vector)
		var camera = new Camera3D(
			new Vector3(4.0, 2.0, 4.0),
			new Vector3(0.0, 1.8, 0.0),
			new Vector3(0.0, 1.0, 0.0),
			60.0,
			CAMERA_PERSPECTIVE
		);

		// Generates some random columns
		var heights = [];
		var positions = [];
		var colors = [];

		for (i in 0...MAX_COLUMNS)
		{
			heights[i] = GetRandomValue(1, 12);
			positions[i] = new Vector3(GetRandomValue(-15, 15), heights[i]/2, GetRandomValue(-15, 15));
			colors[i] = new Color(GetRandomValue(20, 255), GetRandomValue(10, 55), 30, 255);
		}

		SetCameraMode(camera, CAMERA_FIRST_PERSON); // Set a first person camera mode

		SetTargetFPS(60);                           // Set our game to run at 60 frames-per-second
		//--------------------------------------------------------------------------------------

		// Main game loop
		while (!WindowShouldClose())                // Detect window close button or ESC key
		{
			// Update
			//----------------------------------------------------------------------------------
			UpdateCamera(camera);                  // Update camera
			//----------------------------------------------------------------------------------

			// Draw
			//----------------------------------------------------------------------------------
			BeginDrawing();

				ClearBackground(RAYWHITE);

				BeginMode3D(camera);

					DrawPlane(new Vector3(0.0, 0.0, 0.0), new Vector2(32.0, 32.0), LIGHTGRAY); // Draw ground
					DrawCube(new Vector3(-16.0, 2.5, 0.0), 1.0, 5.0, 32.0, BLUE);     // Draw a blue wall
					DrawCube(new Vector3(16.0, 2.5, 0.0), 1.0, 5.0, 32.0, LIME);      // Draw a green wall
					DrawCube(new Vector3(0.0, 2.5, 16.0), 32.0, 5.0, 1.0, GOLD);      // Draw a yellow wall

					// Draw some cubes around
					for (i in 0...MAX_COLUMNS)
					{
						DrawCube(positions[i], 2.0, heights[i], 2.0, colors[i]);
						DrawCubeWires(positions[i], 2.0, heights[i], 2.0, MAROON);
					}

				EndMode3D();

				DrawRectangle( 10, 10, 220, 70, Fade(SKYBLUE, 0.5));
				DrawRectangleLines( 10, 10, 220, 70, BLUE);

				DrawText("First person camera default controls:", 20, 20, 10, BLACK);
				DrawText("- Move with keys: W, A, S, D", 40, 40, 10, DARKGRAY);
				DrawText("- Mouse move to look around", 40, 60, 10, DARKGRAY);

			EndDrawing();
			//----------------------------------------------------------------------------------
		}

		// De-Initialization
		//--------------------------------------------------------------------------------------
		CloseWindow();        // Close window and OpenGL context
		//--------------------------------------------------------------------------------------
	}
}
