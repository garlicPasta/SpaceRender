PIXI = require 'pixi.js'

class Runner

    run: ->
        # create an new instance of a pixi stage
        stage = new PIXI.Stage(0x000000);

        # create a renderer instance
        renderer = new PIXI.WebGLRenderer(800, 600);

        # add the renderer view element to the DOM
        document.body.appendChild(renderer.view);
        lastTime = new Date().getTime()
        fps = 0

        animate = () ->
            nowTime = new Date().getTime()
            deltaTime = nowTime - lastTime
            if deltaTime > 1000
                console.log(fps)
                lastTime = nowTime
                fps = 0
            fps++

            for i in [0..200]
                do ->
                    planets[i].rotation += 0.1;
                    planets[i*2 % 200].x += 0.5;

            requestAnimationFrame( animate );
            renderer.render(stage);

        requestAnimationFrame( animate );

        # create a texture from an image path
        texture = PIXI.Texture.fromImage("jPlanet.png");
        # create a new Sprite using the texture
        
        planets = []

        for i in [0..200]
            do ->
                planets.push(new PIXI.Sprite(texture));
                planets[i].anchor.x = 0.5;
                planets[i].anchor.y = 0.5;
                planets[i].position.x = 20 * i ;
                planets[i].position.y = 15 * i; 

                stage.addChild(planets[i]);

	
module.exports = {
   Runner 
}
