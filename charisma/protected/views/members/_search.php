<div class="wide form">

<?php $form = $this->beginWidget('GxActiveForm', array(
	'action' => Yii::app()->createUrl($this->route),
	'method' => 'get',
)); ?>

	<div class="row">
		<?php echo $form->label($model, 'id'); ?>
		<?php echo $form->textField($model, 'id'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'title'); ?>
		<?php echo $form->textField($model, 'title', array('maxlength' => 15)); ?>
	</div>

<div class="row">
		<?php echo $form->label($model, 'cardnumber'); ?>
		<?php echo $form->textField($model, 'cardnumber', array('maxlength' => 15)); ?>
	</div>
	<div class="row">
		<?php echo $form->label($model, 'firstname'); ?>
		<?php echo $form->textField($model, 'firstname', array('maxlength' => 20)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'middlename'); ?>
		<?php echo $form->textField($model, 'middlename', array('maxlength' => 20)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'lastname'); ?>
		<?php echo $form->textField($model, 'lastname', array('maxlength' => 20)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'issuedate'); ?>
		<?php $form->widget('zii.widgets.jui.CJuiDatePicker', array(
			'model' => $model,
			'attribute' => 'issuedate',
			'value' => $model->issuedate,
			'options' => array(
				'showButtonPanel' => true,
				'changeYear' => true,
				'dateFormat' => 'yy-mm-dd',
				),
			));
; ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'expireddate'); ?>
		<?php $form->widget('zii.widgets.jui.CJuiDatePicker', array(
			'model' => $model,
			'attribute' => 'expireddate',
			'value' => $model->expireddate,
			'options' => array(
				'showButtonPanel' => true,
				'changeYear' => true,
				'dateFormat' => 'yy-mm-dd',
				),
			));
; ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'birthday'); ?>
		<?php $form->widget('zii.widgets.jui.CJuiDatePicker', array(
			'model' => $model,
			'attribute' => 'birthday',
			'value' => $model->birthday,
			'options' => array(
				'showButtonPanel' => true,
				'changeYear' => true,
				'dateFormat' => 'yy-mm-dd',
				),
			));
; ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'sex'); ?>
		<?php echo $form->textField($model, 'sex', array('maxlength' => 7)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'phonenumber'); ?>
		<?php echo $form->textField($model, 'phonenumber', array('maxlength' => 20)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'address'); ?>
		<?php echo $form->textField($model, 'address', array('maxlength' => 30)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'nationality'); ?>
		<?php echo $form->textField($model, 'nationality', array('maxlength' => 40)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'status'); ?>
		<?php echo $form->textField($model, 'status'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'type'); ?>
		<?php echo $form->textField($model, 'type'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'photo'); ?>
		<?php echo $form->textField($model, 'photo', array('maxlength' => 50)); ?>
	</div>

	<div class="row buttons">
		<?php echo GxHtml::submitButton(Yii::t('app', 'Search')); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- search-form -->
