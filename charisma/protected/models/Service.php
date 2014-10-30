<?php

Yii::import('application.models._base.BaseService');

class Service extends BaseService
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}
}