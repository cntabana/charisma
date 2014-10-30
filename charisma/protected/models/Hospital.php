<?php

Yii::import('application.models._base.BaseHospital');

class Hospital extends BaseHospital
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}
}