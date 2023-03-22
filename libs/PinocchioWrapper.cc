#include "pinocchio/parsers/urdf.hpp"
#include <pinocchio/algorithm/frames.hpp>
#include <pinocchio/algorithm/joint-configuration.hpp>

#include "PinocchioWrapper.hpp"

#include <Eigen/Dense>
using Eigen::VectorXd;

extern "C" {
  PinocchioRobot* newPinocchioRobotModel(const std::string urdf_path) {
	PinocchioRobot* robot_ = new PinocchioRobot();
	pinocchio::urdf::buildModel(urdf_path, *(robot_->model));
	robot_->data = new pinocchio::Data(*(robot_->model));
	
	int number_of_joints = 6; // TODO: get this from robot
	robot_->jacobian = new pinocchio::Data::Matrix6x(6, number_of_joints);
	
	// std::vector<std::string> frames;
	// for (auto& f : this->robot_model_.frames) {
	//   frames.push_back(f.name);
	// }
	// // remove universe and root_joint frame added by Pinocchio
	// this->frames_ = std::vector<std::string>(frames.begin() + 2, frames.end());
	// this->init_qp_solver();
	return robot_;
  }

  void PinocchioRobotModel_compute_joint_jacobian(
	PinocchioRobot* robot,
	const Eigen::VectorXd* joint_position,
	unsigned int frame_id
	) {
	
	// TODO: make sure that we don't generate a new Jacobian each time !?
	robot->jacobian->setZero();
	
	// pinocchio::computeFrameJacobian(
	//   *(robot->model),
	//   *(robot->data),
	//   joint_position->data(),
	//   frame_id,
	//   pinocchio::LOCAL_WORLD_ALIGNED,
	//   *(robot->jacobian),
	// );
  }

  void deletePinocchioRobotModel(PinocchioRobot* robot) {
	delete robot->data;
	delete robot->model;
	delete robot->jacobian;
	
	delete robot;
  }
}
