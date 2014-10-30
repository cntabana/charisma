<?php

Yii::import('application.models._base.BaseTraitement');

class Traitement extends BaseTraitement
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}
}