#include <pinocchio/algorithm/frames.hpp>
#include <pinocchio/algorithm/joint-configuration.hpp>

#ifndef __PINOCCHIOWRAPPER_H
#define __PINOCCHIOWRAPPER_H

#ifdef __cplusplus
extern "C" {
#endif
	
	typedef struct PinocchioRobot {
		pinocchio::Model* model;
		pinocchio::Data* data;
		pinocchio::Data::Matrix6x* jacobian;
	} PinocchioRobot;

	/* typedef pinocchio::Data PinocchioRobotModel */
	/* typedef pinocchio::Data PinocchioRobotData; */
	/* typedef Eigen::VectorXd EigenVectorXd; */
	/* typedef pinocchio::Data::Matrix6x PinocchioMatrix; */

	PinocchioRobot* newPinocchioRobotModel(const std::string urdf_path);

	void PinocchioRobotModel_compute_joint_jacobian(
		PinocchioRobot* robot,
		const Eigen::VectorXd* joint_position,
		unsigned int frame_id
	);
	
	void deletePinocchioRobotModel(PinocchioRobot* robot_model);
	
#ifdef __cplusplus
}
#endif
#endif
