var scene; 
var renderer;
var camera;

function createRenderer() {
    renderer = new THREE.WebGLRenderer();
    renderer.setClearColor(0x000000, 1.0);
    renderer.setSize(window.innerWidth, window.innerHeight);
    renderer.shadowMap.enabled = true;
}

function createCamera() {
    camera = new THREE.PerspectiveCamera(
                60,
                window.innerWidth / window.innerHeight,
                0.1,
                1000);

    camera.position.x = 15;
    camera.position.y = 150;
    camera.position.z = 60;
   
   
    

    camera.lookAt(scene.position);

    cameraControl = new THREE.OrbitControls(camera);
}

/**Creation of materials **/
function createLuigiMaterial() {

    var luigiTexture = new THREE.Texture();
    var loader = new THREE.ImageLoader();
    //Loading one texture
    loader.load('Mario_obj/luigiD.jpg', function(image) {
        luigiTexture.image = image;
        luigiTexture.needsUpdate = true;
    });


    var luigiMaterial = new THREE.MeshPhongMaterial();
    //adding the texture to the material
    luigiMaterial.map = luigiTexture;
    

    return luigiMaterial;
}

function createNinjaMaterial() {

    var ninjaTexture = new THREE.Texture();
    var loader = new THREE.ImageLoader();
    loader.load('ninja/Ninja_T.png', function(image) {
        ninjaTexture.image = image;
        ninjaTexture.needsUpdate = true;
    });


    var ninjaMaterial = new THREE.MeshPhongMaterial();
    ninjaMaterial.map = ninjaTexture;
    
    return ninjaMaterial;
}

function createMarioMaterial() {

    var marioTexture = new THREE.Texture();
    var loader = new THREE.ImageLoader();
    loader.load('Mario_obj/marioD.jpg', function(image) {
        marioTexture.image = image;
        marioTexture.needsUpdate = true;
    });
    
    var marioMaterial = new THREE.MeshPhongMaterial();
    marioMaterial.map = marioTexture;


    return marioMaterial;
}

function createAmongMaterial() {

    var amongTexture = new THREE.Texture();
    var loader = new THREE.ImageLoader();
    loader.load('among_us/Plastic_4K_Diffuse.jpg', function(image) {
            amongTexture.image = image;
            amongTexture.needsUpdate = true;
        });

    var normalMap = new THREE.Texture();
    var loader = new THREE.ImageLoader();
    loader.load('among_us/Plastic_4K_Normal.jpg', function(image) {
            normalMap.image = image;
            normalMap.needsUpdate = true;
    });

    var specularMap = new THREE.Texture();
    var loader = new THREE.ImageLoader();
    loader.load('among_us/Plastic_4K_Reflect.jpg', function(image) {
            specularMap.image = image;
            specularMap.needsUpdate = true;
        });

    
    var amongMaterial = new THREE.MeshPhongMaterial();
    amongMaterial.map = amongTexture;
    
    amongMaterial.normalMap = normalMap;
    amongMaterial.normalScale = new THREE.Vector2(1.0, 1.0);

    amongMaterial.specularMap = specularMap;
    amongMaterial.specular = new THREE.Color(0x262626);

    return amongMaterial;
}

function createPumpkinMaterial() {

    var pumpTexture = new THREE.Texture();
    var loader = new THREE.ImageLoader();
    loader.load('pumpkin/PumpkinColor.jpg', function(image) {
        pumpTexture.image = image;
        pumpTexture.needsUpdate = true;
    });
    
    var pumpMaterial = new THREE.MeshPhongMaterial();
    pumpMaterial.map = pumpTexture;
    
   

    return pumpMaterial;
}

/**Creation of Lights**/
function createLights(){
    var intensity=2;
    
    var directionalLight = new THREE.DirectionalLight(0x0000FF , intensity);
    directionalLight.position.set(100, 10, -50);
    directionalLight.name = 'light1';
    directionalLight.castShadow = true;
    scene.add(directionalLight);

    var ambientLight = new THREE.AmbientLight(0x111111);
    scene.add(ambientLight);

    var directionalLight2 = new THREE.DirectionalLight(0xFF0000, intensity);
    directionalLight2.position.set(-100, 10, -50);
    directionalLight2.name = 'light2';
    directionalLight2.castShadow = true;
    scene.add(directionalLight2);

    var ambientLight2 = new THREE.AmbientLight(0x111111);
    scene.add(ambientLight2);

  
    var directionalLight3 = new THREE.DirectionalLight(0xFFFF00, intensity-1.7);
    directionalLight3.position.set(0, 10, 10000000000);
    directionalLight3.name = 'light3';
    directionalLight3.castShadow = true;
    scene.add(directionalLight3);

    var ambientLight3 = new THREE.AmbientLight(0x111111);
    scene.add(ambientLight3);

}
/**Controls the intesity of the lights and if they are on or off**/
function controlIntensity(){
   
    if(offLights==true){
        if(scene.getObjectByName('light1')){
            scene.getObjectByName('light1').intensity=0;
        }
        
        if(scene.getObjectByName('light2')){
            scene.getObjectByName('light2').intensity=0;
        }
        if(scene.getObjectByName('light3')){
            scene.getObjectByName('light3').intensity=0;
        }

    }else{
       
        if(oneTime==true){
            if(scene.getObjectByName('light1')){
                scene.getObjectByName('light1').intensity=2;
            }
            
            if(scene.getObjectByName('light2')){
                scene.getObjectByName('light2').intensity=2;
            }
            if(scene.getObjectByName('light3')){
                scene.getObjectByName('light3').intensity=0.3;
            }
            oneTime=false;
        }

        if(increaseIntensity==true ){
            if(scene.getObjectByName('light1')){
                scene.getObjectByName('light1').intensity+=0.1;
            }
            
            if(scene.getObjectByName('light2')){
                scene.getObjectByName('light2').intensity+=0.1;
            }
            if(scene.getObjectByName('light3')){
                scene.getObjectByName('light3').intensity+=0.1;
            }
                  
        }
        if(decreaseIntensity==true){
            if(scene.getObjectByName('light1')){
                scene.getObjectByName('light1').intensity-=0.1;
            }
            
            if(scene.getObjectByName('light2')){
                scene.getObjectByName('light2').intensity-=0.1;
            }
            if(scene.getObjectByName('light3')){
                scene.getObjectByName('light3').intensity-=0.1;
            }
            
        }
       
       
    }
       
}

/**Controls all related with Rotation **/
function controlRotation(){
    var rotationVelocity=0.005;
    if(increaseVRotation==true){
        //we increse the speed
        rotationVelocity+=0.01;
    }
    if(decreaseVRotation==true){
        //we decrease speed doing to rotate backwards
        rotationVelocity-=0.02;
    }
    if(rotatationActivated==true){
        if(scene.getObjectByName('luigi')){
            //rotate the model in the y direction
            scene.getObjectByName('luigi').rotation.y += rotationVelocity;
            nombre="luigi";
        }
        
        if(scene.getObjectByName('among')){
            scene.getObjectByName('among').rotation.y += rotationVelocity;
            nombre="among";
        }
        if(scene.getObjectByName('ninja')){
            scene.getObjectByName('ninja').rotation.y += rotationVelocity;
            nombre="ninja";
        }
        if(scene.getObjectByName('pump')){
            scene.getObjectByName('pump').rotation.y += rotationVelocity;
            nombre="pump";
            scene.getObjectByName('pump').position.y=70;
        }
        if(scene.getObjectByName('mario')){
            scene.getObjectByName('mario').rotation.y += rotationVelocity;
            nombre="mario";
        }
    }
}

/** Controls everything that concerns the background **/
function changeBackgroundScene(){

    if(changeBackground==true){
        //gives a random color
        var colorB=Math.random() * 0xfffff;
        this.scene.background = new THREE.Color( colorB );
    }
    if(blackBackground==true){
        //gives a black color
        this.scene.background = new THREE.Color( 0x111111 );

    }
    if(whiteBackground==true){
        //gives a white color
        this.scene.background = new THREE.Color( 0xffffff );

    }
  

}

function loadOBJ(obj,nombre){
    var material=new THREE.MeshPhongMaterial();
    //carge every material with its object
    if(nombre=="among"){
        material=createAmongMaterial();
    }
    if(nombre=="luigi"){
        material=createLuigiMaterial();
    }
    if(nombre=="ninja"){
        material=createNinjaMaterial();
    }
    if(nombre=="pump"){
        material=createPumpkinMaterial();
    }
    if(nombre=="mario"){
        material=createMarioMaterial();
    }

    var loader=new THREE.OBJLoader();
    var carga=false;
    

    loader.load(obj,function(object){
        object.traverse(function(child){
            if(child instanceof THREE.Mesh){
                //assigns the materials
                child.material=material;
                child.receiveShadow=true;
                child.castShadow=true;
            }
        });
        object.name=nombre;
        this.scene.add(object);
        
    });
  
}


/**Controls the loading of the object**/
function controlObjectLoaded(){
    if(cargarAmongUs==true){
        //tries to get the objects of the scene
        const selectedObject = this.scene.getObjectByName('among');
        const selectedObject2 = this.scene.getObjectByName('luigi');
        const selectedObject3 = this.scene.getObjectByName('ninja');
        const selectedObject4 = this.scene.getObjectByName('pump');
        const selectedObject5 = this.scene.getObjectByName('mario');
 
        //once it gots the objects of the scene, it removes them
        this.scene.remove(selectedObject);
        this.scene.remove(selectedObject2);
        this.scene.remove(selectedObject3);
        this.scene.remove(selectedObject4);
        this.scene.remove(selectedObject5);
        //now, that the scene is empty, loads the object selected
        loadOBJ("among_us/among us.obj","among");
        //Position the camera,so the object can be seen clearly
        camera.position.z=400;
        //give the object a name to make more easy some functions
        nombre="among";
        //Set it to false, so, it only charges one element at a time
        cargarAmongUs=false;
    }
    if(cargarLuigi==true){
        const selectedObject = this.scene.getObjectByName('among');
        const selectedObject2 = this.scene.getObjectByName('luigi');
        const selectedObject3 = this.scene.getObjectByName('ninja');
        const selectedObject4 = this.scene.getObjectByName('pump');
        const selectedObject5 = this.scene.getObjectByName('mario');

    
        this.scene.remove(selectedObject);
        this.scene.remove(selectedObject2);
        this.scene.remove(selectedObject3);
        this.scene.remove(selectedObject4);
        this.scene.remove(selectedObject5);

        
        loadOBJ("Mario_obj/Luigi_obj.obj","luigi");
        camera.position.z=250;
        nombre="luigi";
        cargarLuigi=false;
    }
    if(cargarPump==true){
        const selectedObject = this.scene.getObjectByName('among');
        const selectedObject2 = this.scene.getObjectByName('luigi');
        const selectedObject3 = this.scene.getObjectByName('ninja');
        const selectedObject4 = this.scene.getObjectByName('pump');
        const selectedObject5 = this.scene.getObjectByName('mario');

    
        this.scene.remove(selectedObject);
        this.scene.remove(selectedObject2);
        this.scene.remove(selectedObject3);
        this.scene.remove(selectedObject4);
        this.scene.remove(selectedObject5);

        
        loadOBJ("pumpkin/Pumpkin.obj","pump");
        camera.position.z=600;
        camera.position.y=100;
        nombre="pump";
        cargarPump=false;
    }
    if(cargarNinja==true){
        const selectedObject = this.scene.getObjectByName('among');
        const selectedObject2 = this.scene.getObjectByName('luigi');
        const selectedObject3 = this.scene.getObjectByName('ninja');
        const selectedObject4 = this.scene.getObjectByName('pump');
        const selectedObject5 = this.scene.getObjectByName('mario');

    
        this.scene.remove(selectedObject);
        this.scene.remove(selectedObject2);
        this.scene.remove(selectedObject3);
        this.scene.remove(selectedObject4);
        this.scene.remove(selectedObject5);


        loadOBJ("ninja/Mini_Ninja.obj","ninja");
        camera.position.z=60;
        camera.position.y=40;
        nombre="ninja";
        cargarNinja=false;
    }
    if(cargarMario==true){
        const selectedObject = this.scene.getObjectByName('among');
        const selectedObject2 = this.scene.getObjectByName('luigi');
        const selectedObject3 = this.scene.getObjectByName('ninja');
        const selectedObject4 = this.scene.getObjectByName('pump');
        const selectedObject5 = this.scene.getObjectByName('mario');

        this.scene.remove(selectedObject);
        this.scene.remove(selectedObject2);
        this.scene.remove(selectedObject3);
        this.scene.remove(selectedObject4);
        this.scene.remove(selectedObject5);


        loadOBJ("Mario_obj/mario_obj.obj","mario");
        camera.position.z=300;
        camera.position.y=100;
        nombre="mario";
        cargarMario=false;
    }
}
/**Controls everything related to the fog **/
function controlFog(nombre){
    var quantity=500;
    //Put an amount of fog for every character
    if(nombre=="among"){
        quantity=500;
    }
    if(nombre=="luigi"){
        quantity=500;
    }
    if(nombre=="ninja"){
        quantity=200;
    }
    if(nombre=="pump"){
        quantity=900;
        
    }
    if(nombre=="mario"){
        quantity=500;
        
    }
    //If it is selected we enable the fog
    if(space==true){
        scene.fog = new THREE.Fog( color, 10, quantity );
        //If the fog is enabled and press C the fog would begin to set to random colors
        if(changeColor==true){
            color= Math.random() * 0xfffff;
            scene.fog = new THREE.Fog( color, 10, quantity );
        }
       
    }else{
        //quit the fog setting the quantity to 0
        scene.fog = new THREE.Fog( color, 10, 0 );
    }
}

/** Controls the movement done in every object **/
function movements(nombre){
    var movimiento=1.0;
    
    if(nombre=="luigi"){
        movimiento=0.5;
    }
    if(nombre=="among"){
        movimiento=1.5;
    }
    if(nombre=="ninja"){
        movimiento=0.1;
    }
    if(nombre=="pump"){
        movimiento=2;
    }
    if(nombre=="mario"){
        movimiento=1;
    }
    
    
    if(scene.getObjectByName(nombre)){
        if(moveLeft==true){
            scene.getObjectByName(nombre).position.x+=movimiento;
        }
        if(moveRight==true){
            scene.getObjectByName(nombre).position.x-=movimiento;
        }
        if(moveUp==true){
            scene.getObjectByName(nombre).position.y-=movimiento;
        }
        if(moveDown==true){
            scene.getObjectByName(nombre).position.y+=movimiento;
        }
    }

}

//called ONCE at start of app
function init() {
    scene = new THREE.Scene();
    scene.background = new THREE.Color( 0x111111 );
	
    createRenderer();
    createCamera();
    //create all the lights
    createLights();

    document.body.appendChild(renderer.domElement);

    render();
}
//called automatically 60fps
function render() {
    

    //this allows you to rotate scene with mouse
    cameraControl.update();
    //Load the object selected
    controlObjectLoaded();
    //Controls all the rotation characteristics
    controlRotation();
    //Controls the movement of the object in the scene
    movements(nombre);
    //Controls the fog of the object in the scene
    controlFog(nombre);
    //Controls the intesity of the lights in the scene
    controlIntensity();
    //Controls the background color
    changeBackgroundScene();
    
    
    renderer.render(scene, camera);

    requestAnimationFrame(render);
}
/** Variables gloables**/
var nombre;
var moveLeft=false;
var moveRight=false;
var moveDown=false;
var moveUp=false;
var cargarLuigi=false;
var cargarMario=false;
var cargarAmongUs=false;
var cargarNinja=false;
var cargarPump=false;
var space=false;
var changeColor=false;
var color= 0xa0a0a0;
var spotLights=false;
var increaseIntensity=false;
var decreaseIntensity=false;
var offLights=false;
var oneTime=false;
var rotatationActivated=true;
var increaseVRotation=false;
var decreaseVRotation=false;
var changeBackground=false;
var whiteBackground=false;
var blackBackground=false;


/**Control Keys **/
//Controls when an specific key is pressed
window.addEventListener("keydown", function(e){
    switch(e.key){
        case 'a':
            moveLeft=true;
            break;
        case 'd':
            moveRight=true;
            break;
        case 'w':
            moveUp=true;
        break;
        case 's':
            moveDown=true;
        break;
        case 'f':
            //activate/desactivate fog
            if(space==true){
                space=false;
            }else{
                space=true;
            }
            
        break;
        case 'r':
            //activate/desactivate rotation
            if(rotatationActivated==true){
                rotatationActivated=false;
            }else{
                rotatationActivated=true;
            }
            
        break;
        case 'l':
            //activate/desactivate lights
            if(offLights==true){
                offLights=false;
                oneTime=true;
            }else{
                offLights=true;
            }
            
        break;
        case 'c':
            //Color of fog
            changeColor=true;
        break;
        case '+':
            //increase Intensity of the lights
            increaseIntensity=true;
        break;
        case '-':
            //decrease Intensity of the lights
            decreaseIntensity=true;
        break;
        case 'p':
            //increase the velocity of rotation 
            increaseVRotation=true;
        break;
        case 'o':
            //decrease the velocity of rotation 
            decreaseVRotation=true;
        break;
        case 'b':
            //change the background's color to a random color
            changeBackground=true;
        break;
        case 'n':
            //change the background's color to black
            blackBackground=true;
        break;
        case 'm':
            //change the background's color to white
            whiteBackground=true;
        break;
    }
});
//Controls when an specific key is not pressed
window.addEventListener("keyup", function(e){
    switch(e.key){
        case 'a':
            moveLeft=false;
            break;
        case 'd':
            moveRight=false;
            break;
        case 'w':
            moveUp=false;
        break;
        case 's':
            moveDown=false;
        break;
        case 'c':
            changeColor=false;
        break;
        case '+':
            increaseIntensity=false;
        break;
        case '-':
            decreaseIntensity=false;
        break;
        case 'p':
            increaseVRotation=false;
        break;
        case 'o':
            decreaseVRotation=false;
        break;
        case 'b':
            changeBackground=false;
        break;
        case 'm':
            whiteBackground=false;
        break;
        case 'n':
            blackBackground=false;
        break;
    }
});

/**Controls what happens when any of buttons on the web are pressed**/
/**All the objects are from TurboSquid**/
document.getElementById("luigi").addEventListener('mousedown',function(e){
 
    cargarLuigi=true;
});
document.getElementById("mario").addEventListener('mousedown',function(e){
 
    cargarMario=true;
    
});
document.getElementById("among").addEventListener("mousedown",function(e){
    cargarAmongUs=true;
});

document.getElementById("ninja").addEventListener("mousedown",function(e){
    cargarNinja=true;
});
document.getElementById("pump").addEventListener("mousedown",function(e){
    cargarPump=true;
});
//Initalizes all the scene
init();
