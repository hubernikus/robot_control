extern crate nalgebra as na;
use euclid::{Vector3D as Vector, Point3D as Point, Rotation3D as Rotation};
// extern crate eculid as euclid;
// use euclid::{Vector3D, Point3D, Rotation3D};
// struct CartesianPosition{
// 	x: f64,
// 	y: f64,
// 	z: f64,
// }

// 7 x 6 = 42  -> number of control points (?)
// How many obstacles (?!)

// Not quite sure what these are for --- will be evaluated in the future
enum U {}
enum Src {}
enum Dst {}

 // f_prec(f64);
type Dist = f64;

struct Pose{
	position: Point<Dist, U>,
	orientation: Rotation<Dist, Src, Dst>,
}

struct Twist{
	linear: Vector<Dist, U>,
	angular: Vector<Dist, U>,
}

struct Sphere{
	pose: Pose,
	twist: Twist,
	radius: Dist,
}


impl Sphere {
	fn get_surface_points(&self, n_points: u32){
		// return vec![]
		// return (sphere.pose.position - position).length() - sphere.radius - margin;
		return
	}

	fn get_surface_distance(&self, position: Point<Dist, U>, margin: f64) -> f64 {
		return self.pose.position.distance_to(position) - self.radius - margin;
	}
	
}

struct ControlPoint{
	pose: Pose,
	radius: Dist,
}

struct Link{
	name: String,
	origin: Pose,
}

struct Joint{
	name: String,
	origin: Pose,
	parent: Link,
	child: Link
}

struct RobotModel{
	name: String,
	links: Vec<ControlPoint>,
	joints: Vec<f64>,
}

// fn create_from_file() -> RobotModel {
// 	return RobotModel("")
// }
// impl RobotModel{
// }

fn compute_jacobian (joint_positions: Vec<f64>) -> Vec<f64> {
	let new_vector = vec![joint_positions[0]];
	return Vec::new();
}

fn main() {
	// Build and run
	// cargo build && ./target/debug/rust_avoider
    println!("\nHello, world! - you did it.\n");
}
